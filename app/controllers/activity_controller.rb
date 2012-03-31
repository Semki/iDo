class ActivityController < ActionController::Base
  layout 'application'
  def new
    @activity_list = ["Eat", "Play", "Swim", "Fly", "Ride", "Fuck"]
  end

  def create
    params[:activity_id]
  end
end