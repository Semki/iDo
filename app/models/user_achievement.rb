class UserAchievement < ActiveRecord::Base
  attr_accessible :achievement_id, :user_id
  
  belongs_to :achievement, :class_name=>'Achievement', :foreign_key=>'achievement_id'
  #belongs_to :achievement, :class_name=>'Achievement', :foreign_key=>'achievement_id'
end
