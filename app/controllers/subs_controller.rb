class SubsController < ApplicationController

	before_filter :is_logged_in?
	
	def new
		@sub = Sub.new
		render :new
	end

	def create
			@sub = Sub.new(params[:sub])

			@links = params[:links].values.map do |link|
				unless link.values.all? { |value| value.blank? }
					Link.new(:title => link[:title], 
									 :url => link[:url],
									 :body => link[:body])		
				end
			end.compact!

		begin
			ActiveRecord::Base.transaction do
				@sub.save!

				@links.each do |link|
					link.sub_id = @sub.id
					link.user_id = @sub.moderator_id
				end

				@links.each { |link| link.save! }
			end

			redirect_to sub_url(@sub)
		rescue 
			notices.push(*@sub.errors)
			@links.each { |link| notices.push(*link.errors) }
			p notices

			render :new
		end
	end

	def show
		@sub = Sub.find(params[:id])

		render :show
	end
end
