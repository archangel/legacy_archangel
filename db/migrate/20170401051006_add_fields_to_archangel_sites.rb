class AddFieldsToArchangelSites < ActiveRecord::Migration[5.0]
  def change
    add_column :archangel_sites, :theme, :string
    add_column :archangel_sites, :favicon, :string
  end
end
