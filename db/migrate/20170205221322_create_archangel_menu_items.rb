class CreateArchangelMenuItems < ActiveRecord::Migration[5.0]
  def change
    create_table :archangel_menu_items do |t|
      t.integer :menu_id
      t.integer :parent_id
      t.string :label
      t.string :attr_id
      t.string :attr_class
      t.string :target
      t.string :highlights_on
      t.string :url
      t.integer :menuable_id
      t.string :menuable_type
      t.string :method
      t.integer :position
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :archangel_menu_items, :deleted_at
    add_index :archangel_menu_items, :label
    add_index :archangel_menu_items, :menu_id
    add_index :archangel_menu_items, :menuable_id
    add_index :archangel_menu_items, :menuable_type
    add_index :archangel_menu_items, :parent_id
  end
end
