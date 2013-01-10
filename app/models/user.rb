class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :screen_name
  # attr_accessible :title, :body

  validates_uniqueness_of :screen_name,
                          :case_sensitive => false,
                          :allow_blank => false

  has_many :authentications, :dependent=>:delete_all
  has_many :events, :dependent=>:delete_all

  def email_required?
    super && false
  end

  def password_required?
    super && false
  end

  def register_omniauth(auth)
    screen_name = get_screen_name(auth)
    self.screen_name = screen_name
    authentications.build(:provider=>auth['provider'], :uid=>auth['uid'],
                          :token=>auth['credentials']['token'],
                          :secret=>auth['credentials']['secret'],
                          :screen_name => screen_name)
  end

  def get_screen_name(auth)
    if auth['provider'] == 'twitter'
      screen_name = auth['extra']['raw_info']['screen_name']
    else
      screen_name = auth['info']['name']
    end
    screen_name
  end

end
