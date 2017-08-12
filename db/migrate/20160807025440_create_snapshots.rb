class CreateSnapshots < ActiveRecord::Migration[5.1]
  def change
    create_table :snapshots do |t|
      t.references :account, index: true, foreign_key: true
      t.money :amount

      t.timestamps null: false
    end
  end
end
