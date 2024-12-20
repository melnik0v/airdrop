module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_or_register_user
    end

    private

    def find_or_register_user
      ip = ActionDispatch::Request.new(env).remote_ip
      ip = "127.0.0.1" if ip == "::1"
      User.find_or_create_by!(fingerprint: request.params["device"]).tap do |user|
        user.ip = ip
        user.name ||= ["[U]", rand(2), rand(3)].join(" ")
      end
    end

    def rand(number)
      RandomNameGenerator.flip_mode.compose(number)
    end
  end
end
