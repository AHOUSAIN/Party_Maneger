Factory.define :host do |host|
  host.first_name                  "AFRAH"
  host.last_name                   "HASSAN"
  host.email                 "ahousain@qatar.cmu.edu"
  host.username                 "ahousain"
  host.password              "foorbar"
  host.password_confirmation "foorbar"
end

Factory.sequence :first_name do |n|
  "Person #{n}"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end


Factory.define :party do |party|
  party.name "Foo bar"
  party.date "12-12-2012"
  party.location "foooooo"
  party.start_time "1700"
  party.end_time "2000"
  party.description "Graduation party "
  party.rsvp_date "12-12-2012"
  party.association :host
end


