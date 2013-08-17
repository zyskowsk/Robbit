class Comment < ActiveRecord::Base
  attr_accessible :body, :link_id, :parent_id, :user_id

  belongs_to :link
  belongs_to :author, 
  					 :class_name => "User",
  					 :foreign_key => :user_id
  belongs_to :parent, 
  					 :class_name => "Comment",
  					 :foreign_key => :parent_id

  has_many :children,
  				 :class_name => "Comment",
  				 :foreign_key => :parent_id

  has_many :votes,
           :class_name => "CommentVote",
           :foreign_key => :comment_id

  def downvote_count
    self.votes.where("value = ?", -1).count
  end

  def score
    self.downvote_count - self.upvote_count 
  end

  def upvote_count
    self.votes.where("value = ?", 1).count
  end
end
