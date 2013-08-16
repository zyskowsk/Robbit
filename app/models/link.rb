class Link < ActiveRecord::Base
  attr_accessible :body, :title, :url, :user_id

  validates :user_id, :title, :url, :presence => true

  belongs_to :sub
  belongs_to :author, 
  					 :class_name => "User",
  					 :foreign_key => :user_id

  has_many :sub_links
  has_many :subs, :through => :sub_links
  has_many :comments

  def comments_by_parent_id
  	comment_hash = Hash.new { [] }
  	self.comments.each do |comment|
  		comment_hash[comment.parent_id] += [comment]
  	end

  	comment_hash
  end
end
