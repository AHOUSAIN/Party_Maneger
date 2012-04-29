# == Schema Information
#
# Table name: parties
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  date        :string(255)
#  location    :string(255)
#  start_time  :string(255)
#  end_time    :string(255)
#  description :string(255)
#  rsvp_date   :string(255)
#  host_id     :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class Party < ActiveRecord::Base
  attr_accessible :name , :date , :location , :start_time ,:end_time , :description , :rsvp_date , :host_id

belongs_to :host

 date_regex = /\d{0-9}\/\d{0-9}\/\d{0-9}/
 validates :name      , :presence => true
 
 validates :host_id     , :presence => true                     
                         
 validates :date , :presence => true
                 
 validates :location , :presence => true
                    
 
 validates :start_time  , :presence => true
                       

 validates :end_time , :presence => true
 
 validates :description , :presence => true
 
 validates :rsvp_date, :presence => true


default_scope :order => 'parties.created_at DESC'


                      

end
