class NearbyChannel < ApplicationCable::Channel
  class << self
    def update_list(current_user)
      users = current_user.same_ip_users.where(online: true)
      users.each do |user|
        broadcast_to(
          user,
          event: "users_list",
          data: users.map { _1.as_json.merge(self: _1.id == current_user.id) }
        )
      end
    end
  end

  def subscribed
    stream_for current_user
    current_user.online!
    self.class.update_list(current_user)
  end

  def unsubscribed
    current_user.offline!
    self.class.update_list(current_user)
  end
end
