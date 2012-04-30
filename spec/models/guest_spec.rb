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

require 'spec_helper'

describe Guest do
  
  before (:each) do
    @party = Factory(:party)
    @attr ={:name  => "Guest" ,
            :email => "ahousain@gmail.com" ,
            :invite_code  => 01 ,
            :expected_attendence => 12,
            :actual_attendence => 9 ,
            
           }
    
  end
  
  it"should create a new instance given a valid attributes" do
   
   @party.guests.create!(@attr)
  end

  
  describe "party associations" do

    before(:each) do
      @guest = @party.guests.create(@attr)
    end

    it "should have a party attribute" do
      @guest.should respond_to(:party)
    end

    it "should have the right associated party" do
      @guest.party_id.should == @party.id
      @guest.party.should == @party
    end
    describe "validations" do

      it "should have a guest id" do
        Guest.new(@attr).should_not be_valid
      end
      
      it "should require nonblank attribytes" do
        @party.guests.build(:name => "").should_not be_valid
        @party.guests.build(:email  => "").should_not be_valid
        @party.guests.build(:invite_code => "").should_not be_valid
        @party.guests.build(:expected_attendence => "").should_not be_valid
        @party.guests.build(:actual_attendence => "").should_not be_valid      
         
end
end  
end
end

