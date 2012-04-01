class ActivitiesController < ApplicationController

  def select
    @activities = Activity.all.collect{|a| [a.name, a.id]}
  end

  def submit
    user_id = current_user.id
    activity_id = params[:activity_id]
    finish_time = Time.new.to_i
    
    User.create_user_achievements(user_id)
    
    Globals.save_activity(user_id, activity_id, finish_time)
    @users = Globals.get_users_doing_the_same(activity_id).collect{|u| User.find(u)}
  end

  def index
    @activities = Activity.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @activities }
    end
  end

  def show
    @activity = Activity.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @activity }
    end
  end

  def new
    @activity = Activity.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @activity }
    end
  end

  def edit
    @activity = Activity.find(params[:id])
  end

  def create
    @activity = Activity.new(params[:activity])

    respond_to do |format|
      if @activity.save
        format.html { redirect_to @activity, :notice => 'Activity was successfully created.' }
        format.json { render :json => @activity, :status => :created, :location => @activity }
      else
        format.html { render :action => "new" }
        format.json { render :json => @activity.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @activity = Activity.find(params[:id])

    respond_to do |format|
      if @activity.update_attributes(params[:activity])
        format.html { redirect_to @activity, :notice => 'Activity was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @activity.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @activity = Activity.find(params[:id])
    @activity.destroy

    respond_to do |format|
      format.html { redirect_to activities_url }
      format.json { head :no_content }
    end
  end
end
