class PagesController < ApplicationController
  def host
    @title = 'Host'
  end

  def party
     @title = 'Party'
  end

  def guest
     @title = 'Guest'
  end
end
