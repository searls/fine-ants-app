class MoveUserOutOfAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts_users do |t|
      t.references :user, index: true, foreign_key: true
      t.references :account, index: true, foreign_key: true


      t.timestamps null: false
    end
    add_index :accounts_users, [:user_id, :account_id], unique: true

    remove_column :accounts, :user_id, :integer
  end
end
