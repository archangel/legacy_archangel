class CreateArchangelSites < ActiveRecord::Migration[5.0]
  def change
    create_table :archangel_sites do |t|
      t.string :name, null: false, default: "Archangel"
      t.string :locale, null: false, default: "en"
      t.string :logo
      t.string :meta_keywords
      t.string :meta_description

      t.timestamps
    end
  end
end
