# == Schema Information
#
# Table name: hosts
#
#  id         :integer         not null, primary key
#  first_name :string(255)
#  last_name  :string(255)
#  email      :string(255)
#  username   :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Host < ActiveRecord::Base
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  attr_accessible :first_name , :last_name , :email , :username
  
   validates :first_name , :presence => true,
                           :length => { :maximum => 50}
                           
   validates :last_name , :presence => true,
                          :length => { :maximum => 50}
   
   validates :email , :presence => true,
                      :format => { :with => email_regex },
                      :uniqueness => { :case_sensitive => false }
   
   validates :username , :presence => true,
                         :length => {:within => 6..10}
  
end
