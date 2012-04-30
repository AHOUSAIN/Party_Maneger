# == Schema Information
#
# Table name: guests
#
#  id                  :integer         not null, primary key
#  name                :string(255)
#  email               :string(255)
#  invite_code         :integer
#  expected_attendence :integer
#  actual_attendence   :integer
#  party_id            :integer
#  created_at          :datetime        not null
#  updated_at          :datetime        not null
#

class Guest < ActiveRecord::Base
  attr_accessible :name , :email ,:invite_code , :expected_attendence , :actual_attendence , :party_id
  belongs_to :party 
  
  validates :party_id     , :presence => true  
  validates :email      , :presence => true
  validates :name      , :presence => true
  validates :invite_code     , :presence => true
  validates :expected_attendence      , :presence => true
  validates :actual_attendence      , :presence => true
 
end
