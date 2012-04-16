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

require 'spec_helper'

describe Host do
  
  before (:each) do
    
    @attr ={:first_name  => "Host" , 
            :last_name => "User" ,
            :email => "hostuser@example.com" ,
            :username => "huser123"
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
  

end
