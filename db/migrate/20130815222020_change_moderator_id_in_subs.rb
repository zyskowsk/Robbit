class ChangeModeratorIdInSubs < ActiveRecord::Migration
  def change
  	rename_column :subs, :moderatior_id, :moderator_id
  end
end
