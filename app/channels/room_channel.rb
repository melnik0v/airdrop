class RoomChannel < ApplicationCable::Channel
  class << self
  end

  def subscribed
    stream_from "p2p_#{params[:identity]}"
  end
end
