require 'rails_helper'

RSpec.describe Album, type: :model do
  
	before(:each) do
		@album = Album.new(name: "Example Album", artist: "Artist Name")
	end

	it { should respond_to(:name) }
	it { should respond_to(:artist) }
	it { should respond_to(:users) }

	it "should be a valid album" do
		expect(@album).to be_valid
	end

	it "should not be a valid if name is not present" do
		@album.name = ""
		expect(@album).to_not be_valid
	end

	it "should not be a valid if email is not present" do 
		@album.artist = ""
		expect(@album).to_not be_valid
	end

end
