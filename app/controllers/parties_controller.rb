class PartiesController < ApplicationController
before_filter :authenticate , :only => [:create,:show,:destroy]

before_filter :authorized_host, :only => :destroy
def create
  @party = current_host.parties.build(params[:party])
  if @party.save
    redirect_to root_path, :flash => { :success => "party created!" }
  else
    @feed_items = []
    render 'pages/host'
  end
end
def show
  @party=Party.find(params[:id])
  @guests = @party.guests.paginate(:page => params[:page])
  
end


def destroy
  @party.destroy
  redirect_to root_path, :flash => { :success => "party deleted!" }
end
 private
 
   def authorized_host
     @party = Party.find(params[:id])
     redirect_to root_path unless current_host?(@party.host)
   end
end