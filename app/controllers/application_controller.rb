class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :authenticate_user!  
  
  def index
    @recents = Globals.recent_activities(20)
  end
end
