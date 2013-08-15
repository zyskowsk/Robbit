class UsersController < ApplicationController

	def new
		render :new
	end

	def create 
		@user = User.new(params[:user])
		if @user.save
			login(@user)
		else
			notices_now = @user.errors.full_messages
			render :new
		end
	end

	def destroy
		#delete user from db
	end
end
