class Achievement < ActiveRecord::Base
  attr_accessible :description, :name, :picture_url, :duration, :count, :activity_id
  belongs_to :activity, :class_name=>'Activity'
  has_many :users, :class_name=>'UserAchievement', :foreign_key=>'achievement_id'
  
  def user_has_gained(user_id)
    return false if activity_id.nil? 
    return Globals.get_activities_count_by_user_and_range(user_id, activity_id, 0, 0) >= count
  end

  def self.get_by_user(user_id)
    UserAchievement.find_by_user_id(user_id).to_a.collect{ |ua| ua.achievement}
  end
end
