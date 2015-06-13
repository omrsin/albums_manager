require 'rails_helper'

RSpec.describe User, type: :model do

	before(:each) do
		@user = User.new(name: "Example User", email: "user@example.com", password: "mypassword", password_confirmation: "mypassword")
	end

	it { should respond_to(:name) }
	it { should respond_to(:email) }

	it "should create a new user in the database" do
		@user.save
		expect(User.count).to eq 1
	end

	it "should be a valid user" do
		expect(@user).to be_valid
	end

	it "should not be a valid if name is not present" do
		@user.name = ""
		expect(@user).to_not be_valid
	end

	it "should not be a valid if email is not present" do 
		@user.email = ""
		expect(@user).to_not be_valid
	end

	it "should not allow a duplicate user with the same email" do
		duplicate_user = @user.dup
		@user.save
		expect(duplicate_user).to_not be_valid
	end

	it "should not allow a duplicate user with the same email even in upper case" do
		duplicate_user = @user.dup
		duplicate_user.email = @user.email.upcase
		@user.save
		expect(duplicate_user).to_not be_valid
	end

	it "should have password length of at least 6 characters" do
		@user.password = @user.password_confirmation = "o"*5
		expect(@user).to_not be_valid
	end

	it "should not be valid if password is not present (or only empty charachters)" do
		@user.password = @user.password_confirmation = " "*6
		expect(@user).to_not be_valid
	end	

end
