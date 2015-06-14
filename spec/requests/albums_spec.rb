require 'rails_helper'

RSpec.describe "Albums", type: :request do

	before(:each) do
		@user = User.new(id: 1, name: "Example User", email: "user@example.com", password: "mypassword", password_confirmation: "mypassword")
		@user.save

		visit login_path

  		fill_in "Email", 	:with => "user@example.com"
		fill_in "Password", :with => "mypassword"

		click_button("Log in")
	end
	
	describe "POST /album" do

		describe "add album" do

			describe "failure" do

				it "should not create a new album" do
					visit new_album_path
					expect(page).to have_http_status(200)

					expect {
						click_button("Add")				  	
					}.to_not change(@user.albums, :count)

					# expect(page).to have_selector('div', text: 'The form contains')

				end
			end

			describe "success" do

				it "should add a new album to the user" do
					visit new_album_path
					expect(page).to have_http_status(200)

					fill_in "Name",    :with => "Example Album"
					fill_in "Artist",  :with => "Example Artist"					
					
					expect {
						click_button("Add")				  	
					}.to change(@user.albums, :count).by(1)

				end
			end  	
		end
	end
end
