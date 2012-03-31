class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  
  has_many :gained_achievements, :class_name=>'UserAchievement', :foreign_key=>'user_id'
  
  def self.find_for_twitter_oauth(uid, signed_in_resource=nil)

    if user = User.where(:email => "#{uid}@gmail.com").first
      user
    else # Create a user with a stub password. 
      User.create!(:email => "#{uid}@gmail.com", :password => Devise.friendly_token[0,20]) 
    end
  end
  
  def self.create_user_achievements(user_id)
    puts "test"
   
    Achievement.all.each { |achievement| 
      if achievement.user_has_gained(user_id)
        if UserAchievement.find_all_by_user_id_and_achievement_id(user_id, achievement.id).first.nil?  
          UserAchievement.create(:user_id => user_id,  :achievement_id => achievement.id)
        end  
      end
    }
  
    
  end
  
end
