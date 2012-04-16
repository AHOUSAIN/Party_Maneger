class PagesController < ApplicationController
  def host
    @title = 'Host'
  end

  def about
     @title = 'About'
  end

  def signin
     @title = 'Sign in'
  end
end
