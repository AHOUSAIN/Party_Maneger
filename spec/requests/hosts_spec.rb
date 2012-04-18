require 'spec_helper'

describe "Hosts" do

  describe "signup" do
    describe "success" do

          it "should make a new host" do
            lambda do
              visit signup_path
              fill_in "First name",         :with => "Example"
              fill_in "Last name",         :with => "Example"
              fill_in "username",         :with => "Exampleus"
              fill_in "Email",        :with => "user@example.com"
              fill_in "Password",     :with => "foobar"
              fill_in "Confirmation", :with => "foobar"
              click_button
              response.should have_selector("div.flash.success",
                                            :content => "Welcome")
              response.should render_template('hosts/show')
            end.should change(Host, :count).by(1)
          end
        end
    describe "failure" do

      it "should not make a new host" do
        lambda do
          visit signup_path
          fill_in "First name",         :with => "Example"
          fill_in "Last name",         :with => "Example"
          fill_in "username",         :with => "Exampleus"
          fill_in "Email",        :with => ""
          fill_in "Password",     :with => ""
          fill_in "Confirmation", :with => ""
          click_button
          response.should render_template('hosts/new')
          response.should have_selector("div#error_explanation")
        end.should_not change(Host, :count)
      end
    end
  end
end