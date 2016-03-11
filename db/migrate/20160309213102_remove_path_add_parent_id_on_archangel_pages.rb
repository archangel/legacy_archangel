class RemovePathAddParentIdOnArchangelPages < ActiveRecord::Migration
  def change
    remove_column :archangel_pages, :path

    add_column :archangel_pages, :position, :integer
    add_column :archangel_pages, :parent_id, :integer, default: 0

    add_index :archangel_pages, :parent_id
  end
end
