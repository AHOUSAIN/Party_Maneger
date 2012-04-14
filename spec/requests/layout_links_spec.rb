require 'spec_helper'

describe "LayoutLinks" do
  
  it "should have a host page at '/'" do
    get '/'
    response.should have_selector('title', :content => "Host")
  end

  it "should have a party page at '/contact'" do
    get '/party'
    response.should have_selector('title', :content => "Party")
  end

  it "should have an Guest page at '/guest'" do
    get '/guest'
    response.should have_selector('title', :content => "Guest")
  end
  it "should have a signup page at '/signup'" do
      get '/signup'
      response.should have_selector('title', :content => "Sign up")
  end
  
end