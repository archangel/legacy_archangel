class AddFieldsToArchangelSites < ActiveRecord::Migration[5.0]
  def change
    add_column :archangel_sites, :theme, default: "default"
    add_column :archangel_sites, :favicon
  end
end
