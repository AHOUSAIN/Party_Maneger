class HostsController < ApplicationController
  before_filter :authenticate, :only => [:index,:edit, :update, :destroy]
  before_filter :correct_host, :only => [:edit, :update]
  before_filter :admin_host,   :only => [:destroy]
  
  def new
    @host = Host.new
    @title = "Sign up"
  end
  def destroy
      Host.find(params[:id]).destroy
      flash[:success] = "User destroyed."
      redirect_to hosts_path
    end
  
  def show
    @host = Host.find(params[:id]) # is refersence in the users spec created afte factory assigns(:hosts)
    @parties = @host.parties.paginate(:page => params[:page])
    @title = @host.last_name
  end
  
  def index
      @title = "All users"
      @hosts = Host.paginate(:page => params[:page])
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
    
    def edit
      @title = "Edit host"
      @host = Host.find(params[:id])
    end
    def update
        @host = Host.find(params[:id])
        if @host.update_attributes(params[:host])
          flash[:success] = "Profile updated."
          redirect_to @host
        else
          @title = "Edit host"
          render 'edit'
        end
      end
      private
      

      def correct_host
            @host = Host.find(params[:id])
            redirect_to(root_path) unless current_host?(@host)
      end
      def admin_host
            redirect_to(root_path) unless current_host.admin?
          end
    
      
  
end
