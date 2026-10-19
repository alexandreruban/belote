# PROTOTYPE, variant C: a custom channel. The stream is chosen from the connection's identity,
# never from client params, so a browser can't ask for another Player's stream.
class Prototype::LiveUpdatesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "#{Prototype::LiveUpdates::Broadcaster::JSON_STREAM}:#{prototype_seat}"
    # Every (re)subscription starts from the current state, so a reconnect heals itself.
    transmit Prototype::LiveUpdates::Broadcaster.json_payload(Prototype::LiveUpdates::Store.state, prototype_seat)
  end

  def play(data)
    Prototype::LiveUpdates::Store.update { Prototype::LiveUpdates::Game.play(it, prototype_seat, data["card"]) }
  rescue Prototype::LiveUpdates::Game::IllegalMove => error
    transmit "error" => error.message
  end
end
