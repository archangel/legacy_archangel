class CreateArchangelSettings < ActiveRecord::Migration
  def change
    create_table :archangel_settings do |t|
      t.string :title
      t.string :logo
      t.integer :per_page, default: 24
    end
  end
end
