namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    admin = Host.create!(:first_name => "Example",
    :last_name => "Example",
                 :email => "example@railstutorial.org",
                 :username => "Example",
                 :password => "foobar",
                 :password_confirmation => "foobar")
      admin.toggle!(:admin)
    99.times do |n|
      first_name  = Faker::Name.first_name
      last_name  = Faker::Name.last_name
      username  = "example-#{n+1}"
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      Host.create!(:first_name => first_name,
      :last_name => last_name,
      :username => username ,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
    
    Party.all(:limit => 6).each do |party|
      50.times do
        party.guests.create!(:name => Faker::Lorem.sentence(5))
      end
    end
    
    end
  end
end