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
  has_many :votes, 
           :class_name => "UserVote",
           :foreign_key => :link_id

  def comments_by_parent_id
  	temp_hash = Hash.new { [] }
    comments_by_parent_id = Hash.new{ [] }
    
  	self.comments.each do |comment|
  		temp_hash[comment.parent_id] += [comment]
  	end

  	temp_hash.each do |key ,value| 
      comments_by_parent_id[key] = value.sort_by(&:score) 
    end

    comments_by_parent_id
  end
     
  def upvote_count
    self.votes.where("value = ?", 1).count
  end

  def downvote_count
    self.votes.where("value = ?", -1).count
  end

  def score
    self.downvote_count - self.upvote_count 
  end
end
