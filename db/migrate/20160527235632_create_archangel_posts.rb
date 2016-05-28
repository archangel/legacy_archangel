class CreateArchangelPosts < ActiveRecord::Migration
  def change
    create_table :archangel_posts do |t|
      t.string :title
      t.text :content
      t.text :excerpt
      t.string :slug
      t.integer :author_id
      t.datetime :deleted_at
      t.datetime :published_at

      t.timestamps null: false
    end

    add_index :archangel_posts, :author_id
    add_index :archangel_posts, :deleted_at
    add_index :archangel_posts, :published_at
    add_index :archangel_posts, :slug, unique: true
    add_index :archangel_posts, :title
  end
end
