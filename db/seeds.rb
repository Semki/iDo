Activity.destroy_all
Achievement.destroy_all

activityEating = Activity.create({:name => 'Eating'})
Achievement.create({:name => 'fatman', :duration => '1', :count => '7', :activity_id => activityEating.id, :picture_url => 'fatman.png' })

activityCoding = Activity.create({:name => 'Coding'})
activityWorking = Activity.create({:name => 'Working'})
activityRunning = Activity.create({:name => 'Running'})
Achievement.create({:name => 'runner of first level', :duration => '100', :count => '25', :activity_id => activityRunning.id, :picture_url => 'runner.png' })

activityPissing = Activity.create({:name => 'Pissing'})
activitySleeping = Activity.create({:name => 'Sleeping'})
activityStudying = Activity.create({:name => 'Studying'})
Achievement.create({:name => 'nerd', :duration => '10', :count => '20', :activity_id => activityStudying.id , :picture_url => 'nerd.png'})

activityWalking = Activity.create({:name => 'Walking'})
activityDrinking = Activity.create({:name => 'Drinking'})
activityPlayingBalalaikaWithMyBear = Activity.create({:name => 'Playing balalaika with my bear'})
Achievement.create({:name => 'russian in hollywood', :duration => '0', :count => '1', :activity_id => activityPlayingBalalaikaWithMyBear.id, :picture_url => 'balalaika.png' })

UserAchievement.destroy_all
Globals.clean
