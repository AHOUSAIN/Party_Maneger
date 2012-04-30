class PagesController < ApplicationController
  def host
    @title = 'Host'
    if signed_in?
    @party = Party.new 
    @feed_items = current_host.feed.paginate(:page => params[:page])
    
  end
end

  def about
     @title = 'About'
  end

  def signin
     @title = 'Sign in'
  end
end
