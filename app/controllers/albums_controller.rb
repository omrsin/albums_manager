class AlbumsController < ApplicationController
	before_action { logged_in_user }

	def index
		@albums = current_user.albums		
	end

	def create
		@album = Album.new(album_params)
	    if @album.save
	    	current_user.albums.push(@album)
		    flash[:success] = "Album added!"
			redirect_to albums_path
	    else
	    	render 'new'
	    end
	end

	def new
		@album = current_user.albums.build
	end

	# def edit
		
	# end

	# def show
		
	# end

	# def update
		
	# end

	# def destroy

	# end

	private

		def album_params
			params.require(:album).permit(:name, :artist)
		end
end
