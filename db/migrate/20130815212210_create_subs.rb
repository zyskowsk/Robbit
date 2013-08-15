class CreateSubs < ActiveRecord::Migration
  def change
    create_table :subs do |t|
      t.string :name
      t.integer :moderatior_id

      t.timestamps
    end
    add_index :subs, :moderatior_id
  end
end
