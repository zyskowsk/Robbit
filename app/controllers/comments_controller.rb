class CommentsController < ApplicationController
	
	before_filter :is_logged_in?

	def create
		@comment = Comment.new(params[:comment])
		@comment.user_id = current_user.id 
		@comment.link_id = params[:link_id]
		if @comment.save
			redirect_to link_url(params[:link_id])
		else
			now_notice.push(*@comment.errors.full_messages)
			render :new
		end
	end

	def destroy
		#TODO: write 
	end

	def downvote
		vote("CommentVote",-1)
	end

	def new
		render :new
	end	

	def upvote
		vote("CommentVote",1)
	end
end
