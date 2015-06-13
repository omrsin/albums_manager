require 'rails_helper'

RSpec.describe UsersController, type: :controller do
	render_views

	describe "GET #new" do

		it "returns http success" do
			get :new
			expect(response).to have_http_status(:success)
		end

		it "should have the right title" do
			get :new							
			expect(response.body).to match  /Create a new user/im
		end
	end

	describe "GET #show" do

		before(:each) do
			@user = User.create!(name: "Example User", email: "user@example.com", password: "mypassword", password_confirmation: "mypassword")			
			user_double = class_double("User").as_stubbed_const(:transfer_nested_constants => true)			
			allow(user_double).to receive(:find).with("#{@user.id}").and_return(@user)			
		end

		it "should be successful" do			
			get :show, :id => @user
			expect(response).to have_http_status(:success)
		end

		it "should include the user's name" do
			get :show, :id => @user
			expect(response.body).to match  Regexp.new(Regexp.escape(@user.name))
		end
	end

	describe "POST #create" do

		describe "invalid submit" do

			before(:each) do
				@attr = { name: "", email: "", password: "", password_confirmation: "" }
				@user = User.new(name: "", email: "", password: "", password_confirmation: "")				
				user_double = class_double("User").as_stubbed_const(:transfer_nested_constants => true)			
				allow(user_double).to receive(:new).and_return(@user)
				allow(@user).to receive(:save).and_return(false)
				allow(@user.errors).to receive(:any?).and_return(true)
			end
				  
			it "should render the 'new' page" do
				post :create, :user => @attr
				expect(response).to render_template('new')
			end

			it "should contain the error messages" do
				get :create, :user => @attr
				expect(response.body).to match  /The form contains (\d)+ error/im
			end

		end

		describe "valid submit" do

			before(:each) do
				@attr = { name: "Example User", email: "user@example.com", password: "mypassword", password_confirmation: "mypassword" }
				@user = User.new(name: "Example User", email: "user@example.com", password: "mypassword", password_confirmation: "mypassword")
				user_double = class_double("User").as_stubbed_const(:transfer_nested_constants => true)			
				allow(user_double).to receive(:new).and_return(@user)
				allow(@user).to receive(:save).and_return(true)				
			end

			it "should redirect to the user's page" do
		        post :create, :user => @attr
		        expect(response).to redirect_to(user_path(@user))
		    end  

		end
	end
end
