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

  def self.save_profile(userprofile)
    node = Globals.connection.createNodeReference("UsersD")
    node.set(userprofile.password, userprofile.username, "password")
  end
  
  def self.save_last_activity(user_id, activity_id, finish_time)
    Globals.connection.startTransaction()
    node = Globals.connection.createNodeReference("Activity")
    if node.exists(user_id)
      last_activity = node.nextSubscript(user_id, "")
      last_finish_date = node.nextSubscript(user_id, last_activity, "")
      node.kill(user_id, last_activity, last_finish_date)
      node.kill(last_activity, last_finish_date, user_id)
    end
    node.set("", user_id, activity_id, finish_time)
    node.set("", activity_id, finish_time, user_id)
    Globals.connection.commit()
  rescue
    Globals.connection.rollback(1)
  end
  
  def self.count_activities(activity_id)
    #node = Globals.connection.createNodeReference("Activity")
  end

end