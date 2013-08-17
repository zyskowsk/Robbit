class SubsController < ApplicationController
	before_filter :is_logged_in?, :only => [:create, :new, :destroy]
	
	def create
		@sub = Sub.new(params[:sub])
		@links = gather_links

		begin
			@sub.save_sub_and_links(@links)
			redirect_to sub_url(@sub)
		rescue 
			create_error_messages
			render :new
		end
	end

	def edit
		@sub = Sub.find(params[:id])
		render :edit
	end

	def front_page
		render :front_page
	end

	def new
		@sub = Sub.new
		render :new
	end

	def show
		@sub = Sub.find(params[:id])
		render :show
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

	private
		def create_error_messages
			notices.push(*@sub.errors)
			@links.each { |link| notices.push(*link.errors) }
		end

		def gather_links
			params[:links].values.map do |link|
				unless link.values.all? { |value| value.blank? }
					Link.new( :title => link[:title], 
									  :url => link[:url],
									  :body => link[:body] )		
				end
			end.compact!
		end
end
