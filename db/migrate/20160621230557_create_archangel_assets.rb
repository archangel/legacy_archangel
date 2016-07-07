class CreateArchangelAssets < ActiveRecord::Migration[5.0]
  def change
    create_table :archangel_assets do |t|
      t.string :title
      t.string :description
      t.string :file
      t.integer :uploader_id
      t.integer :assetable_id
      t.string :assetable_type
      t.integer :file_size
      t.string :content_type

      t.timestamps
    end

    add_index :archangel_assets, :file
    add_index :archangel_assets, :uploader_id
    add_index :archangel_assets, :assetable_id
    add_index :archangel_assets, :assetable_type
    add_index :archangel_assets, :content_type
  end
end
