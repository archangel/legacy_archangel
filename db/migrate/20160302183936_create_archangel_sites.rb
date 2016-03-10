class CreateArchangelSites < ActiveRecord::Migration
  def change
    create_table :archangel_sites do |t|
      t.string :title
      t.string :logo
    end
  end
end
