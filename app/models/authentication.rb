class Authentication < ActiveRecord::Base
  attr_accessible :provider, :screen_name, :secret, :token, :uid, :user_id

  belongs_to :user
end
