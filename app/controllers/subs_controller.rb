class SubsController < ApplicationController

	before_filter :is_logged_in?, :only => [:create, :new, :destroy]
	
	def new
		@sub = Sub.new
		render :new
	end

	def edit
		@sub = Sub.find(params[:id])

		render :edit
	end

	def update
		@sub = Sub.find(params[:id])
		if @sub.update_attributes(params[:sub])
			notices << "#{@sub.name} updated"
			redirect_to sub_url(@sub)
		else
			now_notices.push(*@sub.errors)

			render :edit
		end
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
					link.user_id = @sub.moderator_id 
					link.save! 
					SubLink.create(:sub_id => @sub.id, :link_id => link.id)
				end
			end

			redirect_to sub_url(@sub)
		rescue 
			notices.push(*@sub.errors)
			@links.each { |link| notices.push(*link.errors) }

			render :new
		end
	end

	def show
		@sub = Sub.find(params[:id])

		render :show
	end

	def front_page
		render :front_page
	end
end
