Activity.destroy_all
Achievement.destroy_all

activityEating = Activity.create({:name => 'Eating'})
Achievement.create({:name => 'fat man', :duration => '1', :count => '5', :activity_id => activityEating.id })

activityCoding = Activity.create({:name => 'Coding'})
activityWorking = Activity.create({:name => 'Working'})
activityRunning = Activity.create({:name => 'Running'})
Achievement.create({:name => 'runner of first level', :duration => '100', :count => '25', :activity_id => activityRunning.id })

activityPissing = Activity.create({:name => 'Pissing'})
activitySleeping = Activity.create({:name => 'Sleeping'})
activityStudying = Activity.create({:name => 'Studying'})
Achievement.create({:name => 'nerd', :duration => '10', :count => '20', :activity_id => activityStudying.id })

activityWalking = Activity.create({:name => 'Walking'})
activityDrinking = Activity.create({:name => 'Drinking'})
activityPlayingBalalaykaWithMyBear = Activity.create({:name => 'Playing balalayka with my bear'})
Achievement.create({:name => 'russian stereotype', :duration => '0', :count => '1', :activity_id => activityPlayingBalalaykaWithMyBear.id })

UserAchievement.destroy_all
Globals.clean
