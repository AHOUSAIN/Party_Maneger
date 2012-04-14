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

  it "should have an About page at '/about'" do
    get '/guest'
    response.should have_selector('title', :content => "Guest")
  end
end