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


