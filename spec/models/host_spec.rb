# == Schema Information
#
# Table name: hosts
#
#  id                 :integer         not null, primary key
#  first_name         :string(255)
#  last_name          :string(255)
#  email              :string(255)
#  username           :string(255)
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#  encrypted_password :string(255)
#  salt               :string(255)
#  admin              :boolean
#

require 'spec_helper'

describe Host do
  
  before (:each) do
    
    @attr ={:first_name  => "Host" , 
            :last_name => "User" ,
            :email => "hostuser@example.com" ,
            :username => "huser123",
            :password => "foobar" ,
            :password_confirmation=> "foobar"
           }
    
  end
  
  it"should create a new instance given a valid attributes" do
   Host.create!(@attr)
  end
  
  
  
  it "should require a first name " do
     no_first_name = Host.new(@attr.merge(:first_name=> ""))
     no_first_name.should_not be_valid
  end
  
  it "should require a last name " do
     no_last_name = Host.new(@attr.merge(:last_name=> ""))
     no_last_name.should_not be_valid
  end
  
  it "should require an email " do
      no_email_user = Host.new(@attr.merge(:email => ""))
      no_email_user.should_not be_valid
   end
   
   it "should require an username " do
       no_username = Host.new(@attr.merge(:username => ""))
       no_username.should_not be_valid
    end
    
    # Length validation
    it"should reject first_names that are too long" do

      long_name = 'a' * 51
      long_name_user=Host.new(@attr.merge(:first_name => long_name))
      long_name_user.should_not be_valid

    end
    
    it"should reject last_names that are too long" do

      long_name = 'a' * 51
      long_name_user=Host.new(@attr.merge(:last_name => long_name))
      long_name_user.should_not be_valid

    end
    
     it " should not have short username" do
        short_username = 'a' * 5
        short_username_user = Host.new(@attr.merge(:username =>short_username))
        short_username_user.should_not be_valid

      end

       it " should not have long username" do
          long_username = 'a' * 11
          long_username_user = Host.new(@attr.merge(:username =>long_username))
          long_username_user.should_not be_valid
  end
  
  #format validation
  
  it "should accept valid email adresses" do
    
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      
      valid_eamil_user = Host.new(@attr.merge(:email => address))
      valid_eamil_user.should be_valid
      
    end  
  end  
  
  it "should reject invalid email adresses" do
    
    addresses = %w[user@foo,com THE_USERfoo.bar.org first.last@foo.]
    addresses.each do |address|
      
      invalid_eamil_user = Host.new(@attr.merge(:email => address))
      invalid_eamil_user.should_not be_valid
      
    end  
  end
  
  #uniquness validation
  
  it"should reject duplicate email adressess" do
    Host.create!(@attr)
    user_duplicate_email= Host.new(@attr)
    user_duplicate_email.should_not be_valid
  end  
  
  it"should reject email addresses identical up to case" do
    upcased_email = @attr[:email].upcase
    Host.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = Host.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end  
  
  #password validation
  
  describe "password validations" do
    it "should require a password" do
      no_password_user = Host.new(@attr.merge(:password =>"" , :password_confirmation => ""))
      no_password_user.should_not be_valid
    end
      
      it "should have a matching password" do
        no_matching_password_user = Host.new(@attr.merge(:password_confirmation => "invalid"))
        no_matching_password_user.should_not be_valid

      end  


      it " should not have short passwords" do
        short_password = 'a' * 5
        short_password_user = Host.new(@attr.merge(:password =>short_password , :password_confirmation => short_password))
        short_password_user.should_not be_valid

      end

       it " should not have long passwords" do
          long_password = 'a' * 41
          long_password_user = Host.new(@attr.merge(:password =>long_password , :password_confirmation => long_password))
          long_password_user.should_not be_valid

     end
         describe "password encryption" do
            before (:each) do
              @host = Host.create!(@attr)
            end
            it "should have an encrypted password attribute" do
               @host.should respond_to(:encrypted_password)
             end
             it "should not be black" do
               @host.encrypted_password.should_not be_blank
             end
             describe "has_ password method" do
                 it "should be true if the user passwords match" do
                    @host.has_password?(@attr[:password]).should be_true
                 end

                 it "should be false if the passwords dont match" do
                    @host.has_password?("invalid").should be_false
                 end 

              describe "authonticate method" do
                it"should return nil if username/password missmatch" do
                  wrong_password_user= Host.authenticate(@attr[:username] ,"wrongpass")
                  wrong_password_user.should be_nil
               end

                it"should return nil username/password with no user" do
                  wrong_username_user= Host.authenticate("boo1234" ,@attr[:password])
                  wrong_username_user.should be_nil
                end

                it"should return the user username/password match " do
                   user= Host.authenticate(@attr[:username],@attr[:password])
                   user.should == @host
                 end
               end
               end
             end  
         end
         describe "Party association" do
         before(:each) do
           @host = Host.create(@attr)
           @p1 = Factory(:party, :host => @host, :created_at => 1.day.ago)
           @p2 = Factory(:party, :host => @host, :created_at => 1.hour.ago)
           
         end

         it "should have a party attribute" do
           @host.should respond_to(:parties)
         end
         it "should have the right parties in the right order" do
           @host.parties.should == [@p2, @p1]
         end
         it "should destroy associated parties" do
           @host.destroy
           [@p1, @p2].each do |party|
             lambda do
               Party.find(party)
             end.should raise_error(ActiveRecord::RecordNotFound)
           end
       end
       describe "Party feed" do
         it "should have a Party" do
           @host.should respond_to(:feed)
         end

         it "should include the user's microposts" do
           @host.feed.should include(@p1)
           @host.feed.should include(@p2)
         end

         it "should not include a different host's party" do
           p3 = Factory(:party,
                         :host => Factory(:host, :email => Factory.next(:email)))
           @host.feed.should_not include(p3)
         end
       end
     end
       end
