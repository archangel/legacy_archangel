class CreateArchangelCategorizations < ActiveRecord::Migration[5.0]
  def change
    create_table :archangel_categorizations do |t|
      t.integer :categorizable_id
      t.string :categorizable_type
      t.integer :category_id

      t.timestamps
    end

    add_index :archangel_categorizations, :categorizable_id
    add_index :archangel_categorizations, :categorizable_type
    add_index :archangel_categorizations, :category_id
  end
end
