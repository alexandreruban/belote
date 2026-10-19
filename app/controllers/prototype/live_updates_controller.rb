# PROTOTYPE (throwaway): Live updates without leaking hands
# https://github.com/alexandreruban/belote/issues/9
#
# Three variants, switchable via ?variant= on /prototype/live_updates, which shows the four
# seats of one in-memory Game side by side, each in its own iframe with its own cable connection.
class Prototype::LiveUpdatesController < ApplicationController
  Game = Prototype::LiveUpdates::Game
  Store = Prototype::LiveUpdates::Store

  VARIANTS = {
    "A" => "Turbo Streams per Player",
    "B" => "Turbo page refresh",
    "C" => "Custom channel + Stimulus"
  }

  layout "prototype_live_updates"
  before_action { head :not_found unless Rails.env.local? }
  before_action :set_seat, only: %i[ seat play ]

  def show
    @variant = params[:variant].presence_in(VARIANTS.keys) || "A"
    Store.update(broadcast: false) { it.merge("variant" => @variant) }
    @state = Store.state
    @cable = ActionCable.server.config.cable
  end

  def seat
    @state = Store.state
    @view = Game.view_for(@state, @seat)
  end

  def play
    Store.update { Game.play(it, @seat, params[:card]) }
    respond_after_move
  rescue Game::IllegalMove => error
    render plain: error.message, status: :unprocessable_entity
  end

  def deal
    Store.update { Game.deal(it) }
    head :no_content
  end

  # Plays the rest of the Deal: a random legal card from whoever's turn it is, every 350ms.
  def autoplay
    Thread.new do
      loop do
        sleep 0.35
        done = Rails.application.executor.wrap do
          state = Store.state
          next true unless state["turn"]

          Store.update { Game.play(it, it["turn"], Game.playable(it, it["turn"]).sample) }
          false
        rescue Game::IllegalMove
          false # a human (or another autoplay) moved first
        end
        break if done
      end
    end
    head :no_content
  end

  def settings
    Store.update(broadcast: false) do
      it.merge("bug" => params[:bug] == "1", "refresh_debounce" => params[:refresh_debounce].to_i)
    end
    redirect_to prototype_live_updates_path(variant: Store.state["variant"])
  end

  private
    def set_seat
      @seat = params[:seat].presence_in(Game::SEATS) or head :not_found
    end

    # B: the mover's own page refreshes through the redirect, the other three through the broadcast.
    # A: everyone, the mover included, gets the update on their own stream.
    def respond_after_move
      if Store.state["variant"] == "B"
        redirect_to prototype_live_updates_seat_path(@seat)
      else
        head :no_content
      end
    end
end
