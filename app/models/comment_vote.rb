class CommentVote < ActiveRecord::Base
  attr_accessible :comment_id, :usar_id, :value
end
