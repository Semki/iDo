class Achievement < ActiveRecord::Base
  attr_accessible :description, :name, :picture_url, :duration, :count, :activity_id
  belongs_to :activity, :class_name=>'Activity'
  has_many :users, :class_name=>'UserAchievement', :foreign_key=>'achievement_id'
  
  def user_has_gained(user_id, finish_time)
    return false if activity_id.nil? 
    start_time = finish_time - (60 * 60 * 24 * duration)
    if duration == 0
      start_time = 0
      finish_time = 0
    end
    return Globals.get_activities_count_by_user_and_range(user_id, activity_id, start_time, finish_time) >= count
  end
  
  def self.create_achievements_by_user_id_and_activity_id(user_id, activity_id, finish_time)
    Achievement.find_all_by_activity_id(activity_id).each { |achievement| 
      if achievement.user_has_gained(user_id, finish_time)
        if UserAchievement.find_all_by_user_id_and_achievement_id(user_id, achievement.id).first.nil?  
          UserAchievement.create(:user_id => user_id,  :achievement_id => achievement.id)
        end  
      end
    }
  
  end

  def self.get_by_user(user_id)
    UserAchievement.find_all_by_user_id(user_id).to_a.collect{ |ua| ua.achievement}
  end
end
