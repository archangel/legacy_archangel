class CreateArchangelPages < ActiveRecord::Migration[5.0]
  def change
    create_table :archangel_pages do |t|
      t.string :title
      t.integer :author_id
      t.integer :parent_id
      t.string :path
      t.string :slug
      t.boolean :homepage, default: false
      t.text :content, default: ""
      t.string :meta_keywords
      t.string :meta_description
      t.datetime :deleted_at
      t.datetime :published_at

      t.timestamps
    end

    add_index :archangel_pages, :author_id
    add_index :archangel_pages, :content
    add_index :archangel_pages, :deleted_at
    add_index :archangel_pages, :homepage
    add_index :archangel_pages, :parent_id
    add_index :archangel_pages, :path, unique: true
    add_index :archangel_pages, :published_at
    add_index :archangel_pages, :slug
    add_index :archangel_pages, :title
  end
end
