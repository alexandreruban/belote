module ApplicationCable
  class Connection < ActionCable::Connection::Base
    # PROTOTYPE: the seat comes from the cable URL so one browser can hold four seats in four
    # iframes. The real app identifies the connection by its signed-in User, from the session cookie.
    identified_by :prototype_seat

    def connect
      self.prototype_seat = request.params[:seat].presence_in(Prototype::LiveUpdates::Game::SEATS) || reject_unauthorized_connection
    end
  end
end
