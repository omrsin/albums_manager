require 'rails_helper'

RSpec.describe "Users", type: :request do

	describe "GET /users" do

		describe "sign up form" do

			describe "failure" do

				it "should not create a new user" do
				  visit "users/new"
				  # expect(response).to have_http_status(200)
				end

			end  	
		end
	end
end
