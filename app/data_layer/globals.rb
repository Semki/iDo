 require "java"
 require "C:/Globals/dev/java/lib/JDK16/globalsdb.jar"


module JavaLang
    include_package "java.lang"
    include_package "com.intersys.globals"
end

class Globals
  
  # ^LastUserActivity(user_id, activity_id, finish_time) = ""
  # ^LastActivities(activity_id, finish_time, user_id) = ""
  # ^UserHistory(user_id, start_time, finish_time, activity_id) = ""
  # ^UserActivities(user_id, activity_id, start_time) = ""
  # ^RecentActivities(start_time, activity_id, user_id) = ""
  
  def self.connection
    connection =  JavaLang::ConnectionContext.getConnection()
    unless connection.isConnected
      connection.connect('USER','SYSTEM','DATA')
    end
    connection
  end

  def self.clean
    Globals.connection.startTransaction()
    Globals.connection.createNodeReference("LastUserActivity").kill()
    Globals.connection.createNodeReference("LastActivities").kill()
    Globals.connection.createNodeReference("UserHistory").kill()
    Globals.connection.createNodeReference("UserActivities").kill()
    Globals.connection.createNodeReference("RecentActivities").kill()
    Globals.connection.commit()
  rescue => ex
    Globals.connection.rollback(1)
  end
  
  def self.populate
    first_user = User.find(:first).id.to_i
    last_user = User.find(:last).id.to_i
    first_activity = Activity.find(:first).id.to_i
    last_activity = Activity.find(:last).id.to_i
      
    while true
      user_id = rand(last_user - first_user + 1).to_i + first_user
      activity_id = rand(last_activity-first_activity + 1).to_i + first_activity
      finish_time = 120
      Globals.save_activity(user_id, activity_id, finish_time)
      Achievement.create_achievements_by_user_id_and_activity_id(user_id, activity_id, Time.new.to_i)
      sleep(1.0)  
    end
  end
  
  def self.save_last_activity(user_id, activity_id, finish_time)
    user_node = Globals.connection.createNodeReference("LastUserActivity")
    activities_node = Globals.connection.createNodeReference("LastActivities")
    if user_node.hasSubnodes(user_id)
      last_activity = user_node.nextSubscript(user_id, "")
      last_finish_date = user_node.nextSubscript(user_id, last_activity, "")
      user_node.kill(user_id, last_activity, last_finish_date)
      activities_node.kill(last_activity, last_finish_date, user_id)
    end
    user_node.set("", user_id, activity_id, finish_time)
    activities_node.set("", activity_id, finish_time, user_id)
  end
  
  def self.save_activity_in_history(user_id, activity_id, finish_time)
    time_now = Time.new.to_i
    history_node = Globals.connection.createNodeReference("UserHistory")
    activities_node = Globals.connection.createNodeReference("UserActivities")
    recents_node = Globals.connection.createNodeReference("RecentActivities")
    if history_node.hasSubnodes(user_id)
      last_start_time = history_node.previousSubscript(user_id, "")
      last_finish_time = history_node.nextSubscript(user_id, last_start_time, "")
      last_activity = history_node.previousSubscript(user_id, last_start_time, last_finish_time, "")
      recents_node.kill(last_start_time, last_activity, user_id)
      unless last_finish_time.to_i < time_now
        history_node.kill(user_id, last_start_time, last_finish_time, last_activity)
        history_node.set("", user_id, last_start_time, time_now, last_activity)
      end 
    end
    history_node.set("", user_id, time_now, finish_time, activity_id)
    activities_node.set("", user_id, activity_id, time_now)
    recents_node.set("", time_now, activity_id, user_id)
  end
  
  def self.save_activity(user_id, activity_id, finish_time)
    Globals.connection.startTransaction()
    Globals.save_activity_in_history(user_id, activity_id, finish_time)
    Globals.save_last_activity(user_id, activity_id, finish_time)
    Globals.connection.commit()
  rescue => ex
    Globals.connection.rollback(1)
    raise ex
  end
  
  def self.get_users_doing_the_same(activity_id)
    activities_node = Globals.connection.createNodeReference("LastActivities")
    users = []
    now_time = "" #Time.new.to_i
    time = now_time
    while true
      time = activities_node.nextSubscript(activity_id, time)
      break if time == ""
      
      user = ""
      while true 
        user = activities_node.nextSubscript(activity_id, time, user)
        break if user == ""
        
        users << user
      end
    end
    users
  end

  def self.count_activities(activity_id)
    Globals.get_users_doing_the_same(activity_id).size
  end
  
  def self.get_activities_count_by_user_and_range(user_id, activity_id, start_time = 0, end_time = 0)
    node = Globals.connection.createNodeReference("UserActivities")
    counter = 0
    time = start_time
    while true
      time = node.nextSubscript(user_id, activity_id, time)
      break if time == ""
      break if ((end_time != 0) && (time.to_i > end_time) ) 
      
      counter = counter + 1
    end
    
    counter
  end
  
  def self.has_activities_in_time_window(user_id, activity_id, count, time_window=0)
    # ^UserActivities(user_id, activity_id, start_time) = ""
    node = Globals.connection.createNodeReference("UserActivities")
    result = false
    start_times = [0]
    time = 0
    while true
      time = node.nextSubscript(user_id, activity_id, time)
      break if time == ""
      
      start_times << time.to_i
      start_times.shift if start_times.size > count
      
      if (start_times.size == count && start_times[count-1] - start_times[0] <= time_window)
        result = true
        break
      end
    end
    
    result
  end
  
  def self.recent_activities(count)
    node = Globals.connection.createNodeReference("RecentActivities")
    result = []
    time = ""
    while true
      time = node.previousSubscript(time)
      break if time == ""
      
      activity = ""
      while true
        activity = node.nextSubscript(time, activity)
        break if activity == ""
        
        user = ""
        while true
          user = node.nextSubscript(time, activity, user)
          break if user == ""
          
          result << {:activity_id => activity, :user_id => user}
          
          return result if result.size >= count
        end
      end
    end
    result
  end

end