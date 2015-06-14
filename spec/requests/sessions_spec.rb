require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  
  describe "GET /login" do
    it "works! (now write some real specs)" do
      visit login_path
      expect(page).to have_http_status(200)
    end
  end

  describe "POST /login" do

  	before(:each) do
		@user = User.new(id: 1, name: "Example User", email: "user@example.com", password: "mypassword", password_confirmation: "mypassword")
		@user.save
	end

	it "should login with a valid user" do
  		visit login_path

  		fill_in "Email", 	:with => "user@example.com"
		fill_in "Password", :with => "mypassword"

		click_button("Log in")

		expect(page).to have_selector('a', text: 'Log out')
	end

  end

end
