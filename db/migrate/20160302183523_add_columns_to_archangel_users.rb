class AddColumnsToArchangelUsers < ActiveRecord::Migration
  def change
    add_column :archangel_users, :name, :string, nil: false
    add_column :archangel_users, :username, :string, nil: false
    add_column :archangel_users, :role, :string, default: "user"
    add_column :archangel_users, :avatar, :string
    add_column :archangel_users, :deleted_at, :datetime

    add_index :archangel_users, :deleted_at
    add_index :archangel_users, :username, unique: true
  end
end
