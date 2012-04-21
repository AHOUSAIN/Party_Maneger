class HostsController < ApplicationController
  def new
    @host = Host.new
    @title = "Sign up"
  end
  
  def show
    @host = Host.find(params[:id]) # is refersence in the users spec created afte factory assigns(:hosts)
    @title = @host.last_name
  end
  
  def create
      @host = Host.new(params[:host])
      if @host.save
        sign_in @host
        flash[:success] = "Welcome to Party_Maneger"
        redirect_to @host
      else
        @title = "Sign up"
        render 'new'
      end
    end
  
end
