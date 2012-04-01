class UserBonus < ActiveRecord::Base
  attr_accessible :bonus_id, :user_id
  
  def self.find_by_user_and_bonus(user_id, bonus_id)
    UserBonus.where(:user_id => user_id, :bonus_id => bonus_id)
  end
end
