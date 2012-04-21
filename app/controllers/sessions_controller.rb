class SessionsController < ApplicationController
  def new
    @title ="Sign in"
  end
  
  def create
     
    host = Host.authenticate(params[:session][:username] ,
                             params[:session][:password])
                            
    if host.nil?
    flash.now[:error] = "Invalid email/password combination"  
    @title = "Sign in"
    render 'new'
    
  else
    sign_in host
    redirect_to host
  end
end
  
  def destroy
    sign_out
    redirect_to root_path
    
  end
end
