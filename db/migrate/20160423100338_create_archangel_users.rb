class CreateArchangelUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :archangel_users do |t|
      ## Common
      t.string :name, null: false, default: ""
      t.string :username, null: false, default: ""
      t.string :role
      t.string :avatar

      ## Database authenticatable
      t.string :email, null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email

      ## Lockable
      t.integer  :failed_attempts, default: 0, null: false
      t.string   :unlock_token
      t.datetime :locked_at

      ## Invitations
      t.string :invitation_token
      t.datetime :invitation_created_at
      t.datetime :invitation_sent_at
      t.datetime :invitation_accepted_at
      t.integer :invitation_limit
      t.references :invited_by, polymorphic: true
      t.integer :invitations_count, default: 0
      t.index :invitations_count
      t.index :invitation_token, unique: true
      t.index :invited_by_id

      ## Common
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :archangel_users, :confirmation_token,   unique: true
    add_index :archangel_users, :deleted_at
    add_index :archangel_users, :email,                unique: true
    add_index :archangel_users, :name
    add_index :archangel_users, :reset_password_token, unique: true
    add_index :archangel_users, :role
    add_index :archangel_users, :unlock_token,         unique: true
    add_index :archangel_users, :username,             unique: true
  end
end
