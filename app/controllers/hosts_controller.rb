class HostsController < ApplicationController
  def new
    @host = Host.new
    @title = "Sign up"
  end
  
  def show
    @host = Host.find(params[:id]) # is refersence in the users spec created afte factory assigns(:hosts)
    @title = @host.last_name
  end
end
