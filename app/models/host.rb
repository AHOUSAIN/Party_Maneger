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
#
require 'digest'

class Host < ActiveRecord::Base
  
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  attr_accessor :password
  attr_accessible :first_name , :last_name , :email , :username , :password  ,:password_confirmation
  
   validates :first_name , :presence => true,
                           :length => { :maximum => 50}
                           
   validates :last_name , :presence => true,
                          :length => { :maximum => 50}
   
   validates :email , :presence => true,
                      :format => { :with => email_regex },
                      :uniqueness => { :case_sensitive => false }
   
   validates :username , :presence => true,
                         :length => {:within => 6..10}
  
   validates :password , :presence => true,
                         :confirmation => true,
                         :length => {:within => 6..40}
                         
                         
  before_save :encrypt_password
  
  def has_password?(submitted_password)
    self.encrypted_password == encrypt(submitted_password)
  end
  
  def self.authenticate(username , submitted_password )
    host = find_by_username(username)
    return nil if host.nil?
    return host if host.has_password?(submitted_password)
  end
  
  def self.authenticate_with_salt(id, cookie_salt)
      host = find_by_id(id)
      (host && host.salt == cookie_salt) ? host : nil
    end
  
  private
  def encrypt_password
    self.salt = make_salt if new_record?
    self.encrypted_password = encrypt(password)
  end
  
  def encrypt (string)
    secure_hash("#{salt}--#{string}")
  end  
  
  def make_salt
    secure_hash("#{Time.now.utc}--#{password}")
  end   
  
  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end
  
end

  
