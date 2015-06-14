require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
	render_views  

	describe "GET #new" do

		it "returns http success" do
		  get :new
		  expect(response).to have_http_status(:success)
		end

		it "should display log in" do
			get :new
			expect(response.body).to match /Log in/im 
		end

	end

	describe "POST #create" do

		describe "invalid log in attempt" do

			before(:each) do
				@attr = { :email => "user@example.com", :password => "mypassword" }				
			end

			it "should render the same log in page" do
				@user = User.new
				user_double = class_double("User").as_stubbed_const(:transfer_nested_constants => true)
				allow(user_double).to receive(:find_by).with(email: @attr[:email]).and_return(nil)
				allow(user_double).to receive(:find_by).with(id: nil).and_return(nil)				
				allow(@user).to receive(:authenticate).with(@attr[:password]).and_return(false)

		        post :create, :session => @attr		        
				expect(response).to render_template('new')
		    end

		    it "should contain an invalid credentials messages when the email does not exist" do		    	
				user_double = class_double("User").as_stubbed_const(:transfer_nested_constants => true)
				allow(user_double).to receive(:find_by).with(email: @attr[:email]).and_return(nil)				
				allow(user_double).to receive(:find_by).with(id: nil).and_return(nil)
				allow(@user).to receive(:authenticate).with(@attr[:password]).and_return(true)
		    	
				get :create, :session => @attr
				expect(response.body).to match  /Invalid credentials/im
			end

			it "should contain an invalid credentials messages when it is not possible to authenticate the user" do
				@user = User.new
				user_double = class_double("User").as_stubbed_const(:transfer_nested_constants => true)
				allow(user_double).to receive(:find_by).with(email: @attr[:email]).and_return(@user)				
				allow(user_double).to receive(:find_by).with(id: nil).and_return(nil)
				allow(@user).to receive(:authenticate).with(@attr[:password]).and_return(false)

				get :create, :session => @attr
				expect(response.body).to match  /Invalid credentials/im
			end
		end

		describe "valid log in attepmpt" do
			before(:each) do
				@attr = { :email => "user@example.com", :password => "mypassword" }
				@user = User.new(id: 1, name: "Example User", email: "user@example.com")
				user_double = class_double("User").as_stubbed_const(:transfer_nested_constants => true)
				allow(user_double).to receive(:find_by).with(email: @attr[:email]).and_return(@user)
				allow(user_double).to receive(:find_by).with(id: nil).and_return(@user)
				allow(user_double).to receive(:find_by).with(id: @user.id).and_return(@user)				
				allow(@user).to receive(:authenticate).with(@attr[:password]).and_return(true)
			end

			it "should log in the user" do
		        post :create, :session => @attr
		        expect(controller.current_user).to eq(@user)
		        expect(controller).to be_logged_in
		   end
		      
		      it "should redirect to the user's albums page" do
		        post :create, :session => @attr
		        expect(response).to redirect_to(albums_path)		        
		   end
		end
	end

	describe "DELETE #destroy" do 

		before(:each) do
			@user = User.new(id: 1, name: "Example User", email: "user@example.com")			
		end

		describe "logout" do 
			it "should sign a user out" do
				test_sign_in(@user)
				expect(controller).to be_logged_in
				
				delete :destroy

				expect(controller).to_not be_logged_in				
				expect(response).to redirect_to(root_path)				
			end
		end
	end
end
