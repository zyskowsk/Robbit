class AddSubIdToLinks < ActiveRecord::Migration
  def change
  	add_column :links, :sub_id, :integer
  end
end
