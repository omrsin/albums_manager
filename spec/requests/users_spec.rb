require 'rails_helper'

RSpec.describe "Users", type: :request do

	describe "GET /users" do

		describe "sign up form" do

			describe "failure" do

				it "should not create a new user" do
				  visit new_user_path
				  expect(page).to have_http_status(200)
				  
				  expect {
				  	click_button("Create my account")				  	
				  }.to_not change(User, :count)

				  expect(page).to have_selector('div', text: 'The form contains')

				end
			end

			describe "success" do

				it "should create a new user" do
					visit new_user_path
					expect(page).to have_http_status(200)

					fill_in "Name",         :with => "Username"
					fill_in "Email",        :with => "user@example.com"
					fill_in "Password",     :with => "mypassword"
					fill_in "Password confirmation", :with => "mypassword"
					
					expect {
						click_button("Create my account")				  	
					}.to change(User, :count).by(1)

				end
			end  	
		end
	end
end
