class CommentsController < ApplicationController
	def new

	end	

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
end
