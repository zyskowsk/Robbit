class SessionsController < ApplicationController

	def new
		render :new
	end

	def create
		@user = User.find_by_email(params[:login])
		@user ||= User.find_by_username(params[:user][:login])
		if @user.gave_correct_password?(params[:user][:password])
			login(@user)
		else
			notices_now = @user.errors.full_messages
			render :new
		end
	end

	def destroy
		logout(current_user)
	end
end
