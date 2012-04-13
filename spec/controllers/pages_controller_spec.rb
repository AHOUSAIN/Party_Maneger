require 'spec_helper'

describe PagesController do

  describe "GET 'host'" do
    it "should be successful" do
      get 'host'
      response.should be_success
    end
  end

  describe "GET 'party'" do
    it "should be successful" do
      get 'party'
      response.should be_success
    end
  end

  describe "GET 'guest'" do
    it "should be successful" do
      get 'guest'
      response.should be_success
    end
  end

end
