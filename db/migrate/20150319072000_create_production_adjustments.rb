class CreateProductionAdjustments < ActiveRecord::Migration
  def change
    create_table :production_adjustments, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.date :adjust_date, null: false
      t.string :warehouse_production_amount_id, limit: 36, null: false
      t.float :old_amount, default: 0
      t.float :new_amount, default: 0
      t.string :user_id, limit: 36, null: false
      t.string :user_name, null: false

      t.timestamps
    end
  end
end
