class GuestsController < ApplicationController
before_filter :authenticate , :only => [:create,:destroy]
  
  def index
     @guests = Guest.paginate(:page => params[:page])
  end
  def new
    @party = Party.new(params[:party])
  end
  def create
    @party = Party.new(params[:party])
    @guest = @party.guests.build(params[:guest])
    if @guest.save
      redirect_to @guest, :flash => { :success => "Guest created!" }
    else
      render 'pages/host'
    end
  end
  def show
    @guest = Guest.find(params[:id])
  end
  def destroy
      
  end
  
end
