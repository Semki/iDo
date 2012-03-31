class Achievement < ActiveRecord::Base
  attr_accessible :description, :name, :picture_url, :duration, :count, :activity_id
  belongs_to :activity, :class_name=>'Activity'
  has_many :users, :class_name=>'UserAchievement', :foreign_key=>'achievement_id'
  
end
