class ChangeUserIdInCommentVotes < ActiveRecord::Migration
  def change
  	rename_column :comment_votes, :usar_id, :user_id
  end
end
