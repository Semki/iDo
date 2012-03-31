Activity.destroy_all
Activity.create([{:name => 'Eating'}, {:name => 'Coding'}, {:name => 'Working'}, {:name => 'Running'}, {:name => 'Fucking'}, {:name => 'Pissing'}, {:name => 'Sleeping'} ])
Achievement.create([{:name => 'fat man', :duration => '1', :count => '5' }, {:name => 'runner of first level', :duration => '100', :count => '5' }])
Globals.clean