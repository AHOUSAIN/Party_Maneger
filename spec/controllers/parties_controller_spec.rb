require 'spec_helper'
describe PartiesController do
  render_views

  describe "access control" do
    it "should deny access to 'create'" do
      post :create
      response.should redirect_to(signin_path)
    end
    
    it "should deny access to 'destroy'" do
      delete :destroy, :id => 1
      response.should redirect_to(signin_path)
    end
  end
  
  describe "POST 'create'" do
    
    before(:each) do
      @host = test_sign_in(Factory(:host))
    end

    describe "failure" do

      before(:each) do
        @attr = { :name=> "", 
                  :date => "" , 
                  :location => "" , 
                  :start_time => "" ,
                  :end_time => "" , 
                  :description => "" , 
                  :rsvp_date => "" }
      end

      it "should not create a party" do
        lambda do
          post :create, :party => @attr
        end.should_not change(Party, :count)
      end
      
      it "should re-render the host page" do
        post :create, :party => @attr
        response.should render_template('pages/host')
      end
    end

    describe "success" do
      
      before(:each) do
        @attr = { :name=> "Graduation", 
                  :date => "12-09-89" , 
                  :location => "Doha" , 
                  :start_time => "1900" ,
                  :end_time => "2300" , 
                  :description => "Party_time" , 
                  :rsvp_date => "12-09-89" }
      end
      
      it "should create a Party" do
        lambda do
          post :create, :party => @attr
        end.should change(Party,:count).by(1)
      end
      
      it "should redirect to the root path" do
        post :create, :party => @attr
        response.should redirect_to(root_path)
      end

      it "should have a flash success message" do
        post :create, :party => @attr
        flash[:success].should =~ /party created!/i
      end
    end
  end
  describe "DELETE 'destroy'" do

    describe "for an unauthorized host" do
      
      before(:each) do
        @host = Factory(:host)
        wrong_host = Factory(:host, :email => Factory.next(:email))
        @party = Factory(:party, :host => @host)
        test_sign_in(wrong_host)
      end

      it "should deny access" do
        delete :destroy, :id => @party
        response.should redirect_to(root_path)
      end
    end
    
    describe "for an authorized host" do
      
      before(:each) do
        @host = test_sign_in(Factory(:host))
        @party = Factory(:party, :host => @host)
      end
      
      it "should destroy the partyParty" do
        lambda do
          delete :destroy, :id => @party
          flash[:success].should =~ /deleted/i
          response.should redirect_to(root_path)
        end.should change(Party, :count).by(-1)
      end
    end
  end
end