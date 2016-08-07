class CreateBanks < ActiveRecord::Migration
  def change
    create_table :banks do |t|
      t.string :name
      t.string :fine_ants_adapter

      t.timestamps null: false
    end
  end
end
