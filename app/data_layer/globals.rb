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
    Globals.connection.commit()
  rescue => ex
    Globals.connection.rollback(1)
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
    node = Globals.connection.createNodeReference("UserHistory")
    activities_node = Globals.connection.createNodeReference("UserActivities")
    if node.hasSubnodes(user_id)
      last_start_time = node.previousSubscript(user_id, "")
      last_finish_time = node.previousSubscript(user_id, last_start_time, Time.new.to_i)
      unless last_finish_time == ""
        last_activity = node.previousSubscript(user_id, last_start_time, last_finish_time, "")
        node.kill(user_id, last_start_time, last_finish_time, last_activity)
        node.set("", user_id, last_start_time, Time.new.to_i, last_activity)
      end 
    end
    time = Time.new.to_i
    node.set("", user_id, time, finish_time, activity_id)
    activities_node.set("", user_id, activity_id, time)
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
  
  def self.has_acitivities_in_time_window(user_id, acitivity_id, count, time_window=0)
    return 1
    # ^UserActivities(user_id, activity_id, start_time) = ""
    node = Globals.connection.createNodeReference("UserActivities")
    start_times = [0]
    time = 0
    while true
      time = node.nextSubscript(user_id, activity_id, time)
      break if time == ""
      
    end
  end

end