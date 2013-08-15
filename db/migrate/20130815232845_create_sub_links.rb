class CreateSubLinks < ActiveRecord::Migration
  def change
    create_table :sub_links do |t|
      t.integer :sub_id
      t.integer :link_id

      t.timestamps
    end
    add_index :sub_links, :sub_id
    add_index :sub_links, :link_id
  end
end
