class CreateArchangelComments < ActiveRecord::Migration
  def change
    create_table :archangel_comments do |t|
      t.string :name
      t.string :email
      t.integer :author_id
      t.integer :commentable_id
      t.string :commentable_type
      t.integer :parent_id
      t.text :content
      t.datetime :approved_at
      t.datetime :deleted_at

      t.timestamps null: false
    end

    add_index :archangel_comments, :approved_at
    add_index :archangel_comments, :author_id
    add_index :archangel_comments, :deleted_at
    add_index :archangel_comments, :name
  end
end
