class CreateCoconutNurseryInputs < ActiveRecord::Migration
  def change
    create_table :coconut_nursery_inputs, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :reference_number, null: false
      t.date :nursery_date, null: false
      t.string :item_name, default: "Ripe Fruit"
      t.string :warehouse_id, limit: 36, null: false
      t.integer :input_total_qty, null: false
      t.integer :input_processing_qty, null: false
      t.integer :input_spoil_qty, null: false
      t.date :receive_date, null: false
      t.integer :output_high_qty, default: 0
      t.integer :output_low_qty, default: 0
      t.integer :output_spoil_qty, default: 0
      t.boolean :received, default: false
      t.text :note

      t.timestamps
    end
  end
end
