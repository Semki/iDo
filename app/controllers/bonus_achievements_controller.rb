class BonusAchievementsController < ApplicationController
  # GET /bonus_achievements
  # GET /bonus_achievements.json
  def index
    @bonus_achievements = BonusAchievement.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @bonus_achievements }
    end
  end

  # GET /bonus_achievements/1
  # GET /bonus_achievements/1.json
  def show
    @bonus_achievement = BonusAchievement.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @bonus_achievement }
    end
  end

  # GET /bonus_achievements/new
  # GET /bonus_achievements/new.json
  def new
    @bonus_achievement = BonusAchievement.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @bonus_achievement }
    end
  end

  # GET /bonus_achievements/1/edit
  def edit
    @bonus_achievement = BonusAchievement.find(params[:id])
  end

  # POST /bonus_achievements
  # POST /bonus_achievements.json
  def create
    @bonus_achievement = BonusAchievement.new(params[:bonus_achievement])

    respond_to do |format|
      if @bonus_achievement.save
        format.html { redirect_to @bonus_achievement, :notice => 'Bonus achievement was successfully created.' }
        format.json { render :json => @bonus_achievement, :status => :created, :location => @bonus_achievement }
      else
        format.html { render :action => "new" }
        format.json { render :json => @bonus_achievement.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /bonus_achievements/1
  # PUT /bonus_achievements/1.json
  def update
    @bonus_achievement = BonusAchievement.find(params[:id])

    respond_to do |format|
      if @bonus_achievement.update_attributes(params[:bonus_achievement])
        format.html { redirect_to @bonus_achievement, :notice => 'Bonus achievement was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @bonus_achievement.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /bonus_achievements/1
  # DELETE /bonus_achievements/1.json
  def destroy
    @bonus_achievement = BonusAchievement.find(params[:id])
    @bonus_achievement.destroy

    respond_to do |format|
      format.html { redirect_to bonus_achievements_url }
      format.json { head :no_content }
    end
  end
end
