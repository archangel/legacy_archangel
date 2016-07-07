class CreateArchangelTags < ActiveRecord::Migration[5.0]
  def change
    create_table :archangel_tags do |t|
      t.string :name
      t.string :slug
      t.string :description
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :archangel_tags, :deleted_at
    add_index :archangel_tags, :name
    add_index :archangel_tags, :slug, unique: true
  end
end
