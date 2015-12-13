class User < ActiveRecord::Base

  class << self
    def from_omniauth(auth_hash)
      user = find_or_create_by(uid: auth_hash["uid"], provider: auth_hash['provider'])
      user.name = auth_hash["info"]["name"]
      user.email = auth_hash["info"]["email"]
      user.image_url = auth_hash["info"]["image"]
      user.admin ||= false
      user.super_admin ||= false
      user.save!
      user
    end
  end

end
