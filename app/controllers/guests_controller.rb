class GuestsController < ApplicationController
before_filter :authenticate , :only => [:create,:destroy,:index,:show,:index]
  
  def index
     @guests = Guest.paginate(:page => params[:page])
  end
  def new
    @guest = Guest.new(params[:party])
  end
  def create
   
    @party = Party.new(params[:party])
    @guest = @party.guests.build(params[:guest])
    if @guest.save
      redirect_to @guest, :flash => { :success => "Guest created!" }
    else
      @feed_items = []
      render 'pages/host'
    end
  end
  def show
    @guest = Guest.find(params[:id])
  end
  def destroy
      
  end
  
end
