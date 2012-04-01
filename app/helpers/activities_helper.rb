module ActivitiesHelper
  def activities
    Activity.all.collect{|a| [a.name, a.id]}
  end

  def recent_user_activities
    Globals.recent_activities(20).collect{|ra|
      {:user_id => ra[:user_id], :user_name => User.find(ra[:user_id]).name,
       :user_picture => User.find(ra[:user_id]).image_url, :activity_id => ra[:activity_id] }
    }
  end

  def users_doing_the_same(activity_id)
    Globals.get_users_doing_the_same(activity_id).collect{|ra|
      {:user_id => ra, :user_name => User.find(ra).name,
       :user_picture => User.find(ra).image_url, :activity_id => activity_id }
    }
  end

  def activity_of_current_user
    Globals.get_user_current_activity(current_user.id)
  end
end
