class GuestsController < ApplicationController
 
  
  def show
    @guest = Guest.find(params[:id])
  end
  
  def create
      @guest = Guest.new(params[:party])
      if @guest.save
        
        redirect_to @guest
      else
        
        render 'pages/host'
      end
    end
  
end
