 require "java"
 require "C:/Globals/dev/java/lib/JDK16/globalsdb.jar"


module JavaLang
    include_package "java.lang"
    include_package "com.intersys.globals"
end

class UserProfile
  attr_accessor :username, :password
  def register
    
  end

  
  def save
    #.new_user(username, password, password_confirmation)
   puts "test"
     connection =  JavaLang::ConnectionContext.getConnection()
         
                unless connection.isConnected
                
		            puts 'trying to connect'
                    connection.connect('USER','SYSTEM','DATA')
	             print connection
			

	        end
    node = connection.createNodeReference("UsersD")
    node.set(@password, @username, "password");
    
    # Здесь нужно сохранить его в базу
  end

  def login
    # todo
  end
end
