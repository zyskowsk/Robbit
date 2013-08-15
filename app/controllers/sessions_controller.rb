class SessionsController < ApplicationController

	def new
		render :new
	end

	def create
		@login = params[:users][:login]
		@user = User.find_by_email(@login)
		@user ||= User.find_by_username(@login)
		if @user && @user.gave_correct_password?(params[:user][:password])
			login(@user)
		else
			flash.now[:notices] << "Incorrect username or password"
			render :new
		end
	end

	def destroy
		logout(current_user)
	end
end
