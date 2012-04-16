require 'spec_helper'

describe "LayoutLinks" do
  
  it "should have a host page at '/'" do
    get '/'
    response.should have_selector('title', :content => "Host")
  end

  it "should have a About page at '/about'" do
    get '/about'
    response.should have_selector('title', :content => "About")
  end

  it "should have an Sign in page at '/signin'" do
    get '/signin'
    response.should have_selector('title', :content => "Sign in")
  end
  it "should have a sign up page at '/signup'" do
      get '/signup'
      response.should have_selector('title', :content => "Sign up")
  end
  
end