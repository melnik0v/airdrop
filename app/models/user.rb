class User < ApplicationRecord
  def same_ip_users
    User.where(ip: ip)
  end

  def online!
    update!(online: true)
  end

  def offline!
    update!(online: false)
  end
end
