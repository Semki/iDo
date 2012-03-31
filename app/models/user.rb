class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  
  def self.find_for_twitter_oauth(uid, signed_in_resource=nil)
    if user = User.where(:email => "#{uid}@gmail.com").first
      user
    else # Create a user with a stub password. 
      User.create!(:email => "#{uid}@gmail.com", :password => Devise.friendly_token[0,20]) 
    end
  end
  
end
