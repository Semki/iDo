module ActivitiesHelper
  def activities
    Activity.all.collect{|a| [a.name, a.id]}
  end

  def recent_user_activities
    Globals.recent_activities(20).collect{|ra|
      {:user_id => ra[:user_id], :user_name => User.find(ra[:user_id]).name,
       :user_picture => User.find(ra[:user_id]).image_url, :activity_name => Activity.find(ra[:activity_id]).name,
       :activity_picture => "/images/activities/#{Activity.find(ra[:activity_id]).picture_url}" }
    }
  end
end
