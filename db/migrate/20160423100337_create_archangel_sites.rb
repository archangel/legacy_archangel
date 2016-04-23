class CreateArchangelSites < ActiveRecord::Migration
  def change
    create_table :archangel_sites do |t|
      t.string :title
      t.string :logo
      t.string :meta_keywords
      t.string :meta_description

      t.timestamps null: false
    end
  end
end
