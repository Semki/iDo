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
    node.set(userprofile.password, userprofile.username, "password");
  end

end

#     node = connection.createNodeReference("UsersD")
#    node.set(@password, @username, "password");