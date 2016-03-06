class AddAuthorIdToArchangelPages < ActiveRecord::Migration
  def change
    add_column :archangel_pages, :author_id, :integer, nil: false

    add_index :archangel_pages, :author_id
  end
end
