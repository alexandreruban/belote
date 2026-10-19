# PROTOTYPE: the three candidate ways of telling four browsers that a move happened.
#
#   A  Turbo Streams, one stream per Player: render the table once per viewer, send each its own.
#   B  Turbo page refresh: one shared Game stream that only says "refresh"; each browser
#      re-fetches its own page over HTTP, rendered for whoever is signed in.
#   C  Custom Action Cable channel: send each Player a JSON view; a Stimulus client renders it.
#
# With state["bug"] on, each variant makes the mistake that comes most naturally to it.
module Prototype::LiveUpdates::Broadcaster
  Game = Prototype::LiveUpdates::Game

  STREAM = "prototype_live_updates"
  JSON_STREAM = "prototype_live_updates_json"

  module_function

  def broadcast(state)
    case state["variant"]
    when "A" then turbo_streams(state)
    when "B" then refresh
    when "C" then json(state)
    end
  end

  def turbo_streams(state)
    if state["bug"]
      # Bug: render the table once, for the Player who moved, and fan it out to everyone,
      # as you would with a single shared Game stream.
      html = render_table(Game.view_for(state, state["last_actor"]))
      Game::SEATS.each { Turbo::StreamsChannel.broadcast_replace_to(STREAM, it, target: "table", html: html) }
    else
      Game::SEATS.each do |seat|
        Turbo::StreamsChannel.broadcast_replace_to(STREAM, seat, target: "table", html: render_table(Game.view_for(state, seat)))
      end
    end
  end

  # Carries no game data at all, so there is no bug to make here.
  def refresh
    Turbo::StreamsChannel.broadcast_refresh_to(STREAM)
  end

  def json(state)
    Game::SEATS.each { ActionCable.server.broadcast("#{JSON_STREAM}:#{it}", json_payload(state, it)) }
  end

  def json_payload(state, seat)
    payload = Game.view_for(state, seat)
    # Bug: serialize the Game with its hands and let the browser pick its own hand out.
    # The table still looks right; only the wire gives it away.
    state["bug"] ? payload.merge("hands" => state["hands"]) : payload
  end

  def render_table(view)
    ApplicationController.render(partial: "prototype/live_updates/table", locals: { view: view })
  end
end
