class SessionsController < ApplicationController

	def new
		user = User.find(session["warden.user.user.key"][0][0])
		@current_user = user
		if user["admin"] == nil
			redirect_to users_path
		else
			redirect_to root_path
			#render json: {user: user}
		end
		
	end

	def create
		user = User.where(email: user_params[:email]).first
		puts user
		if user && user.password == user_params[:password]
	      # Save the user ID in the session so it can be used in
	      # subsequent requests
	      session[:current_user_id] = user.id
	      flash[:notice] = "Successful Login"
	      redirect_to user
	    else
	    	flash[:notice] = "Invalid credentials"
 	    	redirect_to root_url
	    end
	end

	def destroy
		@user = User.find(session["warden.user.user.key"][0][0])
		user = @user.attributes
		user["lastAccess"] = DateTime.now
		@user.update_attributes(user)
		@current_user = session[:current_user_id] = nil
		session["warden.user.user.key"][0][0] = 0
    	redirect_to root_url
	end

	def user_params
      params.require(:session).permit(:email, :password)
    end

    def google_logged_in
      if session["warden.user.user.key"] then true else false end
    end
end