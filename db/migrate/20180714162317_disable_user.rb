class DisableUser < ActiveRecord::Migration[5.1]
  def change
    change_table :users do |t|
      t.boolean :disabled, default: false, null: false
    end
  end
end
