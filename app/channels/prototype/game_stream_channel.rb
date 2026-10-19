# PROTOTYPE, variant B: Turbo's own streams channel plus a catch-up refresh.
#
# A page misses every move made between its render and its subscription, and every move made
# while it was disconnected: Action Cable replays nothing. Both cases end in a (re)subscription,
# which carries the version the page was rendered at (data-version on turbo_stream_from), so the
# server sends that one browser a refresh whenever the Game has moved on since.
class Prototype::GameStreamChannel < Turbo::StreamsChannel
  def subscribed
    super
    transmit self.class.turbo_stream_refresh_tag.to_str if !subscription_rejected? && behind?
  end

  private
    def behind?
      params[:version].to_i < Prototype::LiveUpdates::Store.state["version"]
    end
end
