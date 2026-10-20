# PROTOTYPE (throwaway): Lobby and table screens
# https://github.com/alexandreruban/belote/issues/13
#
# Three structurally different variants of the Lobby and the table, switchable via ?variant= on
# /prototype/screens. ?scenario= picks a moment of the Game (see Prototype::Screens::Scene) and
# ?lang=fr|en the UI language. Read-only: every action is a link to the scenario it would lead to.
class Prototype::ScreensController < ApplicationController
  VARIANTS = {
    "A" => "Felt table",
    "B" => "Board",
    "C" => "Pocket"
  }

  layout "prototype_screens"
  before_action { head :not_found unless Rails.env.local? }

  def show
    @variant = params[:variant].presence_in(VARIANTS.keys) || "A"
    @lang = params[:lang].presence_in(%w[ fr en ]) || "fr"
    @scenario = params[:scenario].presence_in(Prototype::Screens::Scene::SCENARIOS.keys) || "lobby"
    @scene = Prototype::Screens::Scene.build(@scenario)
  end
end
