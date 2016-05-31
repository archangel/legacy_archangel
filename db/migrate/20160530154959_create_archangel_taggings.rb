class CreateArchangelTaggings < ActiveRecord::Migration
  def change
    create_table :archangel_taggings do |t|
      t.integer :taggable_id
      t.string :taggable_type
      t.integer :tag_id

      t.timestamps null: false
    end
  end
end
