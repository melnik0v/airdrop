class NearbyChannel < ApplicationCable::Channel
  class << self
    def update_list(current_user)
      users = current_user.same_ip_users.where(online: true)
      users.each do |user|
        broadcast_to(
          user,
          event: "users_list",
          data: users.as_json
        )
      end
    end

    def ask(from:, to:)
      broadcast_to(
        to,
        event: "ask",
        data: from.as_json
      )
    end

    def decline(from:, to:)
      broadcast_to(
        to,
        event: "decline",
        data: from.as_json
      )
    end
  end

  def subscribed
    stream_or_reject_for current_user
    current_user.online!
    self.class.update_list(current_user)
  end

  def unsubscribed
    current_user.offline!
    self.class.update_list(current_user)
  end

  def ask(params)
    user = User.find_by!(fingerprint: params["fingerprint"])
    self.class.ask(from: current_user, to: user)
  end
end
