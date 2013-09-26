class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :token_authenticatable, :timeoutable

  devise :omniauthable, :omniauth_providers => [:twitter]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :password, :password_confirmation, :remember_me, :email
  attr_accessible :name, :provider, :uid, :oauth_token, :oauth_secret

  has_and_belongs_to_many :searches

  def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first  
    unless user
      # email params is actually the name
      user = User.create(
        name: auth.extra.raw_info.name, 
        provider: auth.provider, 
        uid: auth.uid, 
        email: auth.info.name,
        oauth_token: auth.credentials.token, 
        oauth_secret: auth.credentials.secret, 
        password: Devise.friendly_token[0,20])                                           
    end
    user
  end

  # def self.new_with_session(params, session)
  #   super.tap do |user| 
  #     if data = session["devise.twitter_data"] && session["devise.twitter_data"]["extra"]["raw_info"]
  #       user.email = data["name"] if user.email.blank?
  #     end
  #   end
  # end

end
