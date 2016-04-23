class CreateArchangelPages < ActiveRecord::Migration
  def change
    create_table :archangel_pages do |t|
      t.string :title
      t.text :content
      t.integer :author_id
      t.integer :parent_id
      t.integer :position
      t.string :path
      t.string :slug
      t.string :meta_keywords
      t.string :meta_description
      t.datetime :deleted_at
      t.datetime :published_at

      t.timestamps null: false
    end

    add_index :archangel_pages, :author_id
    add_index :archangel_pages, :deleted_at
    add_index :archangel_pages, :parent_id
    add_index :archangel_pages, :path, unique: true
    add_index :archangel_pages, :slug
    add_index :archangel_pages, :title
  end
end
