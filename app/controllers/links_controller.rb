class LinksController < ApplicationController
	before_filter :is_logged_in?, :only => [:new, :create, :upvote, :downvote]

	def create
		@link = Link.new(params[:link])
		@link.user_id = current_user.id
		@sub_ids = params[:sub_ids]

		begin
			@link.save_link_and_subs(@sub_ids)
			redirect_to root_url
		rescue
			create_error_messages
			render :new
		end
	end

	def destroy
		#TODO: write
	end

	def downvote
		vote("UserVote",-1)
	end

	def edit
		@link = Link.find(params[:id])

		render :edit
	end

	def new
		@link = Link.new
		render :new
	end

	def show
		@link = Link.find(params[:id])
		render :show
	end

	def update
		@link = Link.find(params[:id])
		
		begin 
			@link.update_link_and_subs(params)

			notices << "#{@link.title} updated"
			redirect_to link_url(@link)
		rescue
			now_notices.push(*@link.errors.full_messages)
			render :edit
		end
	end

	def upvote
		vote("UserVote",1)
	end

	private 
		def create_error_messages
			now_notices.push(*@link.errors.full_messages)
			@subs = @sub_ids.map { |id| Sub.find_by_id(id) }.compact
			unless @subs.empty?
				now_notices.push(*@subs.map{ |sub| sub.errors.full_messages }.flatten)
			end
		end
end
