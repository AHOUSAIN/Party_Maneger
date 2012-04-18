require 'spec_helper'

describe HostsController do

  render_views
  describe "GET 'show'" do

       before(:each) do
         @host = Factory(:host)
       end

       it "should be successful" do
         get :show, :id => @host
         response.should be_success
       end

       it "should find the right host" do
         get :show, :id => @host
         assigns(:host).should == @host
       end
       it "should have the right title" do
             get :show, :id => @host
             response.should have_selector("title", :content => @host.last_name)
           end

           it "should include the host's name" do
             get :show, :id => @host
             response.should have_selector("h1", :content => @host.last_name)
           end

           it "should have a profile image" do
             get :show, :id => @host
             response.should have_selector("h1>img", :class => "gravatar")
           end
         end
  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
    it "should have the right title" do
      get 'new'
      response.should have_selector("title", :content => "Sign up")
    end
    
  end
  describe "POST 'create'" do

      describe "failure" do

        before(:each) do
          @attr = { :first_name => "",:last_name => "",:username => "" ,:email => "", :password => "",
                    :password_confirmation => "" }
        end

        it "should not create a host" do
          lambda do
            post :create, :host => @attr
          end.should_not change(Host, :count)
        end

        it "should have the right title" do
          post :create, :host => @attr
          response.should have_selector("title", :content => "Sign up")
        end

        it "should render the 'new' page" do
          post :create, :host => @attr
          response.should render_template('new')
        end
      end
      describe "success" do

            before(:each) do
              @attr = { :first_name => "New", :last_name => "User",:username => "nuser12",:email => "user@example.com",
                        :password => "foobar", :password_confirmation => "foobar" }
            end

            it "should create a host" do
              lambda do
                post :create, :host => @attr
              end.should change(Host, :count).by(1)
            end

            it "should redirect to the host show page" do
              post :create, :host => @attr
              response.should redirect_to(host_path(assigns(:host)))
            end 
            it "should have a welcome message" do
                    post :create, :host => @attr
                    flash[:success].should =~ /Welcome to Party_Maneger/i
                  end   
          end
    end
end

