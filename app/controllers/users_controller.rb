class UsersController < ApplicationController
	before_filter :is_logged_in?, :only => :show

	def create 
		@user = User.new(params[:user])
		if @user.save
			login(@user)
		else
			flash.now[:notices] = @user.errors.full_messages
			render :new
		end
	end

	def new
		@user = User.new
		render :new
	end

	def show
		@user = User.find(params[:id])

		render :show
	end
end
