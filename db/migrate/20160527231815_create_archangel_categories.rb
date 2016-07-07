class CreateArchangelCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :archangel_categories do |t|
      t.string :name
      t.string :slug
      t.string :description
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :archangel_categories, :deleted_at
    add_index :archangel_categories, :name
    add_index :archangel_categories, :slug, unique: true
  end
end
