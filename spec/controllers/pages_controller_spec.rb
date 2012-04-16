require 'spec_helper'

describe PagesController do
  render_views
  
  before (:each) do
    @base_title = "Party Manager | "
  end
  describe "GET 'host'" do
    it "should be successful" do
      get 'host'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'host'
      response.should have_selector("title" , :content => "Host")
      
    end
  end

  describe "GET 'party'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end
    it "should have the right title" do
      get 'about'
      response.should have_selector("title" , :content => "About")
    
    end
  end

  describe "GET 'guest'" do
    it "should be successful" do
      get 'signin'
      response.should be_success
    end
    it "should have the right title" do
      get 'signin'
      response.should have_selector("title" , :content => "Sign in")

    end
  end

end
