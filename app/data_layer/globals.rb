 require "java"
 require "C:/Globals/dev/java/lib/JDK16/globalsdb.jar"


module JavaLang
    include_package "java.lang"
    include_package "com.intersys.globals"
end

class Globals
  
  def self.connection
    connection =  JavaLang::ConnectionContext.getConnection()
    unless connection.isConnected
      puts 'trying to connect'
      connection.connect('USER','SYSTEM','DATA')
      print connection
    end
    connection
  end

  def self.clean
    Globals.connection.startTransaction()
    Globals.connection.createNodeReference("LastUserActivity").kill()
    Globals.connection.createNodeReference("LastActivities").kill()
    Globals.connection.createNodeReference("UserHistory").kill()
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
    if node.hasSubnodes(user_id)
      last_start_time = node.previousSubscript(user_id, "")
      last_finish_time = node.previousSubscript(user_id, last_start_time, "")
      if last_finish_time > Time.new.to_i
        last_activity = node.previousSubscript(user_id, last_start_time, last_finish_time, "")
        node.kill(user_id, last_start_time, last_finish_time, last_activity)
        node.set("", user_id, last_start_time, Time.new.to_i, last_activity)
      end 
    end
    node.set("", user_id, Time.new.to_i, finish_time, activity_id)
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
  
  def self.count_activities(activity_id)
    activities_node = Globals.connection.createNodeReference("LastActivities")
    counter = 0
    now_time = Time.new.to_i
    time = now_time
    while true
      time = activities_node.nextSubscript(activity_id, time)
      break if time == ""
      
      user = ""
      while true 
        user = activities_node.nextSubscript(activity_id, time, user)
        break if user == ""
        
        counter = counter + 1
      end
    end
    counter
  end

  def self.GetActivitiesCountByUserAndRange(userId, activityId, startTime = 0, endTime = 0)
    
  end

end