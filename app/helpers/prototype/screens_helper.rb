# PROTOTYPE (throwaway): Lobby and table screens
module Prototype::ScreensHelper
  Copy = Prototype::Screens::Copy

  def tr(key, **vars) = Copy.t(@lang, key, **vars)

  def rank_text(card) = Copy.rank(@lang, card.rank)
  def card_text(card) = "#{rank_text(card)}#{card.symbol}"
  def suit_name(suit) = Copy.suit(@lang, suit)
  def suit_symbol(suit) = Prototype::Screens::Card::SYMBOLS.fetch(suit)

  # "vous"/"you" for the viewer, the username for everyone else.
  def player_name(position) = position == :me ? tr(:you) : @scene.username(position)

  def scene_path(scenario) = prototype_screens_path(variant: @variant, lang: @lang, scenario:)

  # The scenario a stubbed action leads to (:join, :leave, :take, :pass, :play), and a link to it.
  def action_scenario(action) = Prototype::Screens::Scene::AFTER.fetch(@scene.key, {}).fetch(action, @scene.key)
  def action_path(action) = scene_path(action_scenario(action))

  # Why only some cards are playable, when it's the viewer's turn.
  def must_text
    case @scene.must
    when :follow_suit then tr(:must_follow, suit: suit_name(@scene.led_suit))
    when :trump then tr(:must_trump, suit: suit_name(@scene.led_suit))
    else tr(:any_card)
    end
  end

  def deal_result_text(deal)
    return tr(:dropped) if deal[:result] == :dropped
    "#{tr(:deal_result, name: player_name(deal[:taker]), suit: suit_name(deal[:trump]))} · #{tr(deal[:result])}"
  end
end
