class CreateArchangelTaggings < ActiveRecord::Migration[5.0]
  def change
    create_table :archangel_taggings do |t|
      t.integer :taggable_id
      t.string :taggable_type
      t.integer :tag_id

      t.timestamps
    end

    add_index :archangel_taggings, :taggable_id
    add_index :archangel_taggings, :taggable_type
    add_index :archangel_taggings, :tag_id
  end
end
