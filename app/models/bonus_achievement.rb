class BonusAchievement < ActiveRecord::Base
  attr_accessible :description, :name, :picture_url
  
  has_many :user_bonuses, :class_name=>'UserBonus', :foreign_key=>'bonus_id'
  
  def self.create_user_bonuses(user_id)
    user = User.find(user_id)
    return if user.nil?
    ids = Array.new
    UserAchievement.find_all_by_user_id.each {|user_achievement | ids.push(user_achievement.id) }
    
    bonuses_ids = Globals.get_bonuses_ids(ids.sort)
    bonuses_ids.each { |id| 
      UserBonus.create(:user_id => user_id, :bonus_id => id) if UserBonus.find_by_user_and_bonus(user_id, id).first.nil? }
  end
  
  def self.init_bonuses_achievements(ids)
    Globals.init_bonuses_achievements(ids.sort)
  end
end
