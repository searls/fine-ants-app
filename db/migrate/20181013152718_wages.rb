class CreateWages < ActiveRecord::Migration[5.2]
  def change
    create_table :wages do |t|
      t.money :amount
      t.date :date
      t.string :description
      t.timestamps null: false
    end
  end
end
