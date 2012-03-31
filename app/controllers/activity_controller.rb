class ActivityController < ActionController::Base
  def new
    @activity_list = ["Eat", "Play", "Swim", "Fly", "Ride", "Fuck"]
  end

  def create
    params[:activity_id]
  end
end