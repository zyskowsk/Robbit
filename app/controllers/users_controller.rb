class UsersController < ApplicationController
	before_filter :is_logged_in?, :only => :show

	def new
		@user = User.new
		render :new
	end

	def create 
		@user = User.new(params[:user])
		if @user.save
			login(@user)
		else
			flash.now[:notices] = @user.errors.full_messages
			render :new
		end
	end

	def show
		@user = User.find(params[:id])

		render :show
	end

	def index

	end

	def destroy
		#delete user from db
	end
end
