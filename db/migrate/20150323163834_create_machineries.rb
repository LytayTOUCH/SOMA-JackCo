class CreateMachineries < ActiveRecord::Migration
  def change
    create_table :machineries, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :name, limit: 50, null: false
      t.string :machinery_type_id, limit: 36, null: false
      t.boolean :status, default: true
      t.string :manufacturer
      t.string :model
      t.string :registration_number
      t.string :year
      t.text :note

      t.timestamps
    end
  end
end
