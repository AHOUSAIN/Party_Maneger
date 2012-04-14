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
      get 'party'
      response.should be_success
    end
    it "should have the right title" do
      get 'party'
      response.should have_selector("title" , :content => "Party")
    
    end
  end

  describe "GET 'guest'" do
    it "should be successful" do
      get 'guest'
      response.should be_success
    end
    it "should have the right title" do
      get 'guest'
      response.should have_selector("title" , :content => "Guest")

    end
  end

end
