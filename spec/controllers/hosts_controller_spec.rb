require 'spec_helper'

describe HostsController do

  render_views
  describe "GET 'index'" do

      describe "for non-signed-in hosts" do
        it "should deny access" do
          get :index
          response.should redirect_to(signin_path)
          flash[:notice].should =~ /sign in/i
        end
      end

      describe "for signed-in hosts" do

        before(:each) do
          @host = Factory(:host)
          test_sign_in(@host)
          second = Factory(:host, :first_name => "Bob", :email => "another@example.com")
          third  = Factory(:host, :first_name => "Ben", :email => "another@example.net")

          
          @hosts = [@host, second, third]
                  30.times do
                    @hosts << Factory(:host, :first_name => Factory.next(:first_name),
                                             :email => Factory.next(:email))
        end
        
        it "should have an element for each host" do
                get :index
                @hosts[0..2].each do |host|
                  response.should have_selector("li", :content => host.name)
                end
              end

              it "should paginate hosts" do
                get :index
                response.should have_selector("div.pagination")
                response.should have_selector("span.disabled", :content => "Previous")
                response.should have_selector("a", :href => "/users?page=2",
                                                   :content => "2")
                response.should have_selector("a", :href => "/users?page=2",
                                                   :content => "Next")
              end

        it "should be successful" do
          get :index
          response.should be_success
        end

        it "should have the right title" do
          get :index
          response.should have_selector("title", :content => "All hosts")
        end

        it "should have an element for each host" do
          get :index
          @hosts.each do |host|
            response.should have_selector("li", :content => host.first_name)
          end
        end
      end
    end
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
              @attr = { :first_name => "New", :last_name => "host",:username => "nhost12",:email => "host@example.com",
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
    describe "GET 'edit'" do

        before(:each) do
          @host = Factory(:host)
          test_sign_in(@host)
        end

        it "should be successful" do
          get :edit, :id => @host
          response.should be_success
        end

        it "should have the right title" do
          get :edit, :id => @host
          response.should have_selector("title", :content => "Edit host")
        end

        it "should have a link to change the Gravatar" do
          get :edit, :id => @host
          gravatar_url = "http://gravatar.com/emails"
          response.should have_selector("a", :href => gravatar_url,
                                             :content => "Visit The official gravatar page to change your profile image")
        end
      end
      
      describe "PUT 'update'" do

          before(:each) do
            @host = Factory(:host)
            test_sign_in(@host)
          end

          describe "failure" do

            before(:each) do
              @attr = { :first_name => "",:last_name => "",:email => "", :username => "", :password => "",
                        :password_confirmation => "" }
            end

            it "should render the 'edit' page" do
              put :update, :id => @host, :host => @attr
              response.should render_template('edit')
            end

            it "should have the right title" do
              put :update, :id => @host, :host => @attr
              response.should have_selector("title", :content => "Edit host")
            end
          end

          describe "success" do

            before(:each) do
              @attr = { :first_name => "New",:last_name => "Name",:username => " newName", :email => "user@example.org",
                        :password => "barbaz", :password_confirmation => "barbaz" }
            end

            it "should change the hosts's attributes" do
              put :update, :id => @host, :host => @attr
              @host.reload
              @host.first_name.should  == @attr[:first_name]
               @host.last_name.should  == @attr[:last_name]
               @host.username.should  == @attr[:username]
              @host.email.should == @attr[:email]
            end

            it "should redirect to the hosts show page" do
              put :update, :id => @host, :host => @attr
              response.should redirect_to(host_path(@host))
            end

            it "should have a flash message" do
              put :update, :id => @host, :host => @attr
              flash[:success].should =~ /updated/
            end
          end
        end
        describe "authentication of edit/update pages" do

            before(:each) do
              @host = Factory(:host)
            end

            describe "for non-signed-in hosts" do

              it "should deny access to 'edit'" do
                get :edit, :id => @host
                response.should redirect_to(signin_path)
              end

              it "should deny access to 'update'" do
                put :update, :id => @host, :host => {}
                response.should redirect_to(signin_path)
              end
            end
            describe "for signed-in hosts" do

                  before(:each) do
                    wrong_host = Factory(:host, :email => "user@example.net")
                    test_sign_in(wrong_host)
                  end

                  it "should require matching hosts for 'edit'" do
                    get :edit, :id => @host
                    response.should redirect_to(root_path)
                  end

                  it "should require matching hosts for 'update'" do
                    put :update, :id => @host, :user => {}
                    response.should redirect_to(root_path)
                  end
                end
              end
          end
       describe "DELETE 'destroy'" do

          before(:each) do
            @host = Factory(:host)
          end

          describe "as a non-signed-in hosts" do
            it "should deny access" do
              delete :destroy, :id => @host
              response.should redirect_to(signin_path)
            end
          end

          describe "as a non-admin host" do
            it "should protect the page" do
              test_sign_in(@host)
              delete :destroy, :id => @host
              response.should redirect_to(root_path)
            end
          end

          describe "as an admin host" do

            before(:each) do
              admin = Factory(:host, :email => "admin@example.com", :admin => true)
              test_sign_in(admin)
            end

            it "should destroy the host" do
              lambda do
                delete :destroy, :id => @host
              end.should change(Host, :count).by(-1)
            end

            it "should redirect to the hosts page" do
              delete :destroy, :id => @host
              response.should redirect_to(hosts_path)
            end
          end
        end
      end