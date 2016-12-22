class CreateArchangelPosts < ActiveRecord::Migration[5.0]
  def change
    create_table :archangel_posts do |t|
      t.string :title
      t.string :path
      t.string :slug
      t.integer :author_id
      t.text :content, default: ""
      t.string :meta_keywords
      t.string :meta_description
      t.string :feature
      t.datetime :deleted_at
      t.datetime :published_at

      t.timestamps
    end

    add_index :archangel_posts, :author_id
    add_index :archangel_posts, :content
    add_index :archangel_posts, :deleted_at
    add_index :archangel_posts, :path, unique: true
    add_index :archangel_posts, :published_at
    add_index :archangel_posts, :slug
    add_index :archangel_posts, :title
  end
end
