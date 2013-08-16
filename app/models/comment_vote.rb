class CommentVote < ActiveRecord::Base
  attr_accessible :comment_id, :user_id, :value

  validates :comment_id, :uniqueness => { :scope => :user_id }
  validates :value, :inclusion => { :in => [1, -1] }

  belongs_to :user
  belongs_to :comment
end
