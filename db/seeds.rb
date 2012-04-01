Activity.destroy_all
Achievement.destroy_all

activity_eating = Activity.create({:name => 'Eating', :picture_url => 'eating.png'})
fatman = Achievement.create({:name => 'fatman', :duration => '1', :count => '7', :activity_id => activity_eating.id, :picture_url => 'fatman.png' })

#activity_coding = Activity.create({:name => 'Coding'})
activity_working = Activity.create({:name => 'Working', :picture_url => 'working.png'})
activity_cleaning = Activity.create({:name => 'Cleaning', :picture_url => 'cleaning.png'})
activity_shopping = Activity.create({:name => 'Shopping', :picture_url => 'shopping.png'})
activity_running = Activity.create({:name => 'Running', :picture_url => 'running.png'})
Achievement.create({:name => 'runner of first level', :duration => '100', :count => '25', :activity_id => activity_running.id, :picture_url => 'running.png' })

#activity_pissing = Activity.create({:name => 'Pissing', :picture_url => ''})
#activity_sleeping = Activity.create({:name => 'Sleeping', :picture_url => ''})
activity_studying = Activity.create({:name => 'Studying', :picture_url => 'studying.png'})

Achievement.create({:name => 'nerd', :duration => '10', :count => '20', :activity_id => activity_studying.id , :picture_url => 'nerd.png'})

activity_walking = Activity.create({:name => 'Walking with dog', :picture_url => 'walking_with_dog.png'})
activity_drinking = Activity.create({:name => 'Drinking', :picture_url => 'drinking.png'})
activity_playing_balalaika = Activity.create({:name => 'Playing balalaika with my bear', :picture_url => 'playing_balalaika_with_my_bear.png'})
balalaika_achievement = Achievement.create({:name => 'balalaika perfomance', :duration => '0', :count => '1', :activity_id => activity_playing_balalaika.id, :picture_url => 'balalaika.png' })


bonus = Achievement.create({:name => 'bonus!', :description => 'secret bonus for playing balalaika and eating!',  :duration => '0', :count => '1', :picture_url => 'bonus.png' })
ids = []
ids.push(balalaika_achievement.id)
ids.push(fatman.id)
Achievement.init_bonus_achievements(bonus.id, ids)

UserAchievement.destroy_all
Globals.clean
