class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.integer :parent_id
      t.integer :link_id

      t.timestamps
    end
    add_index :comments, :parent_id
    add_index :comments, :link_id
  end
end
