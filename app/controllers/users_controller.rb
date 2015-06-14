class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def show
		logged_in_user
		@user = User.find(params[:id])
	end

	def create
		@user = User.new(user_params)
		if @user.save
			log_in(@user)
			redirect_to albums_path	
		else
			render 'new'
		end		
	end

	private

		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end
end
