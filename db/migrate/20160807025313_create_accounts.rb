class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.references :bank, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.string :foreign_id
      t.string :name

      t.timestamps null: false
    end
  end
end
