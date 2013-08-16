class LinksController < ApplicationController

	before_filter :is_logged_in?, :only => [:new, :create]

	def new
		@link = Link.new

		render :new
	end

	def create
		@link = Link.new(params[:link])
		@link.user_id = current_user.id
		@sub_ids = params[:sub_ids]

		begin
			ActiveRecord::Base.transaction do
				@link.save!
				@sub_ids.each do |sub_id|
					SubLink.create!(:sub_id => sub_id, :link_id => @link.id)
				end
			end

			redirect_to root_url
		rescue
			now_notices.push(*@link.errors.full_messages)
			@subs = @sub_ids.map { |id| Sub.find_by_id(id) }.compact
			unless @subs.empty?
				now_notices.push(*@subs.map{ |sub| sub.errors.full_messages }.flatten)
			end

			render :new
		end
	end

	def update
		@link = Link.find(params[:id])
		@new_sub_ids = params[:sub_ids] - @link.sub_ids
		@old_sub_ids = @link.sub_ids - params[:sub_ids]

		begin 
			ActiveRecord::Base.transaction do
				@link.update_attributes(params[:link])

				@new_sub_ids.each do |sub_id| 
					SubLink.create(:sub_id => sub_id, :link_id => @link.id)
				end

				@old_sub_ids.each do |sub_id|
					SubLink.find_by_sub_id_and_link_id(sub_id, @link.id).destroy
				end
			end
			notices << "#{@link.title} updated"
			redirect_to link_url(@link)
		rescue
			now_notices.push(*@link.errors.full_messages)

			render :edit
		end
	end

	def show
		@link = Link.find(params[:id])

		render :show
	end

	def edit
		@link = Link.find(params[:id])

		render :edit
	end
end
