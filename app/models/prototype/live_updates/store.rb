# PROTOTYPE: one in-memory Game shared by the whole process. Kept on Rails config so
# development code reloading doesn't wipe it; restart the server to start afresh.
module Prototype::LiveUpdates::Store
  module_function

  def state
    Rails.application.config.x.prototype_live_updates_state ||= Prototype::LiveUpdates::Game.new_state
  end

  # Applies a change and broadcasts the result under one lock, so broadcasts go out in move order.
  def update(broadcast: true)
    mutex.synchronize do
      Rails.application.config.x.prototype_live_updates_state = yield(state)
      Prototype::LiveUpdates::Broadcaster.broadcast(state) if broadcast
      state
    end
  end

  def mutex
    Rails.application.config.x.prototype_live_updates_mutex ||= Mutex.new
  end
end
