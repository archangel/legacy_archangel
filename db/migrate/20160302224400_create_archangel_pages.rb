class CreateArchangelPages < ActiveRecord::Migration
  def change
    create_table :archangel_pages do |t|
      t.string :title
      t.text :content
      t.string :path
      t.string :slug
      t.string :meta_keywords
      t.string :meta_description

      t.timestamps null: false
    end

    add_index :archangel_pages, :path, unique: true
  end
end
