class CreateArchangelTags < ActiveRecord::Migration
  def change
    create_table :archangel_tags do |t|
      t.string :name
      t.string :slug
      t.string :description
      t.datetime :deleted_at

      t.timestamps null: false
    end

    add_index :archangel_tags, :name
    add_index :archangel_tags, :slug, unique: true
  end
end
