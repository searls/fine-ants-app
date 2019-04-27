class DisableAccounts < ActiveRecord::Migration[5.2]
  def change
    change_table :accounts do |t|
      t.boolean :disabled, default: false, null: false
    end
  end
end
