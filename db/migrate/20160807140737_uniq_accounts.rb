class UniqAccounts < ActiveRecord::Migration[5.1]
  def change
    add_index :accounts, [:bank_id, :foreign_id], unique: true
  end
end
