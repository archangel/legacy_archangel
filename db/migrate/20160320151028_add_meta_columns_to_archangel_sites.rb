class AddMetaColumnsToArchangelSites < ActiveRecord::Migration
  def change
    add_column :archangel_sites, :meta_keywords, :string, null: true
    add_column :archangel_sites, :meta_description, :string, null: true
  end
end
