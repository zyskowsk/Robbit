class LinksController < ApplicationController

	def new
		@link = Link.new

		render :new
	end

	def create

	end

	
end
