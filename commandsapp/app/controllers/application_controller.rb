class ApplicationController < ActionController::Base
	protect_from_forgery with: :null_session #muy importante sacarlo
	def index
		@posts = Post.all
	end
end
