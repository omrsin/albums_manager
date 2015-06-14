require 'rails_helper'

RSpec.describe AlbumsController, type: :controller do
	render_views 

	before(:each) do
		@user = User.new(id: 1, name: "Example User", email: "user@example.com")		
		test_sign_in(@user)
	end
	
	describe "GET #index" do

		before(:each) do			
			@album = Album.new(name: "Example Album", artist: "Artist" )
			@user.albums.push(@album)			
		end

		it "returns http success" do
			get :index
			expect(response).to have_http_status(:success)
		end

		it "contains the album" do
			get :index
			expect(response.body).to match  Regexp.new(Regexp.escape(@album.name))
		end
	end

	describe "GET #new" do 
		
		it "returns http success" do
			get :new
			expect(response).to have_http_status(:success)
		end

	end

	describe "POST #create" do

		describe "invalid submit" do

			before(:each) do
				@attr = { name: "", artist: "" }				
			end
				  
			it "should render the 'new' page" do
				post :create, :album => @attr
				expect(response).to render_template('new')
			end

		end

		describe "valid submit" do

			before(:each) do
				@attr = { name: "Example Album", artist: "Example Artist" }				
			end			

			it "should redirect to the user's albums page" do
		        post :create, :album => @attr
		        expect(response).to redirect_to(albums_path)
		    end  

		end
	end
end
