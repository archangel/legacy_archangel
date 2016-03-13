class AddColumnsToArchangelPages < ActiveRecord::Migration
  def change
    add_column :archangel_pages, :position, :integer
    add_column :archangel_pages, :parent_id, :integer, null: true

    add_index :archangel_pages, :parent_id
  end
end
