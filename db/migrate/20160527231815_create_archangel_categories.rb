class CreateArchangelCategories < ActiveRecord::Migration
  def change
    create_table :archangel_categories do |t|
      t.string :name
      t.string :slug
      t.string :description
      t.datetime :deleted_at

      t.timestamps null: false
    end

    add_index :archangel_categories, :name
    add_index :archangel_categories, :slug, unique: true
  end
end
