class HostsController < ApplicationController
  def new
    @title = "Sign up"
  end
  
  def show
    @host = Host.find(params[:id]) # is refersence in the users spec created afte factory assigns(:users)
  end
end
