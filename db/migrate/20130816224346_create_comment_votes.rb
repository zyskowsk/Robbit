class CreateCommentVotes < ActiveRecord::Migration
  def change
    create_table :comment_votes do |t|
      t.integer :comment_id
      t.integer :usar_id
      t.integer :value

      t.timestamps
    end
    add_index :comment_votes, :comment_id
    add_index :comment_votes, :usar_id
  end
end
