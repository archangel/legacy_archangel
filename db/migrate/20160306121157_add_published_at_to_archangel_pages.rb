class AddPublishedAtToArchangelPages < ActiveRecord::Migration
  def change
    add_column :archangel_pages, :published_at, :datetime
  end
end
