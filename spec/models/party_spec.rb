# == Schema Information
#
# Table name: parties
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  date        :date
#  location    :string(255)
#  start_time  :time
#  end_time    :time
#  description :string(255)
#  rsvp_date   :date
#  host_id     :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

require 'spec_helper'

describe Party do
    before(:each) do
      @host = Factory(:host)
      @attr = { :name=> "lorem ipsum", 
                :date => "12-23-2010" , 
                :location => "Regency Halls" , 
                :start_time => "1900" ,
                :end_time => "2300" , 
                :description => "Graduation party for my son" , 
                :rsvp_date => "12-23-2010"  }
   
    end

    it "should create a new instance with valid attributes" do
      @host.parties.create!(@attr)
    end
    describe "host associations" do

      before(:each) do
        @party = @host.parties.create(@attr)
      end

      it "should have a host attribute" do
        @party.should respond_to(:host)
      end

      it "should have the right associated host" do
        @party.host_id.should == @host.id
        @party.host.should == @host
      end
    end
    describe "validations" do

      it "should have a host id" do
        Party.new(@attr).should_not be_valid
      end

      it "should require nonblank attribytes" do
        @host.parties.build(:name => "").should_not be_valid
         @host.parties.build(:date => "").should_not be_valid
          @host.parties.build(:location => "").should_not be_valid
           @host.parties.build(:start_time => "").should_not be_valid
            @host.parties.build(:end_time => "").should_not be_valid
             @host.parties.build(:description => "").should_not be_valid
             @host.parties.build(:rsvp_date => "").should_not be_valid
            end
            
            

    end
end
