require 'spec_helper'

describe SessionsController do

  render_views
    describe "GET 'new'" do
      it "should be successful" do
        get :new
        response.should be_success
      end
       it "should have the right title" do
          get :new
          response.should have_selector("title", :content => "Sign in")
        end
    end
    describe "Post 'create'" do
      describe "failure" do
        before (:each) do
          @attr = {:username => "email123" ,:password => "invalid"}
        end

        it " should have the right title" do
          post :create , :session => @attr
         response.should have_selector("title", :content => "Sign in")
        end
        it " should re- render to new page" do
          post :create , :session => @attr
          response.should render_template('new')
        end

        it " should have flash.now message" do
          post :create , :session => @attr
          flash.now[:error].should =~ /invalid/i
        end
      end # end of failure
      describe "with valid email and password" do

            before(:each) do
                    @host = Factory(:host)
                    @attr = { :username => @host.username, :password => @host.password }
                  end

                  it "should sign the user in" do
                    post :create, :session => @attr
                    controller.current_host.should == @host
                    controller.should be_signed_in
                  end

                  it "should redirect to the host show page" do
                    post :create, :session => @attr
                    response.should redirect_to(host_path(@host))
                  end
                end

              end # of success
              describe "DELETE 'destroy'" do

                 it "should sign a host out" do
                   test_sign_in(Factory(:host))
                   delete :destroy
                   controller.should_not be_signed_in
                   response.should redirect_to(root_path)
                 end
               end

            end

           
