class CreateArchangelCategorizations < ActiveRecord::Migration
  def change
    create_table :archangel_categorizations do |t|
      t.integer :categorizable_id
      t.string :categorizable_type
      t.integer :category_id

      t.timestamps null: false
    end
  end
end
