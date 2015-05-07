class CreateDistributions < ActiveRecord::Migration
  def change
    create_table :distributions, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :label, null: false
      t.string :planting_project_id, null: false
      
      # This field store array of distribution's UOM
      # - Jackfruit [Kg, Unit]
      # - Coconut [Unit]
      t.text :uoms, null: false
      
      # This field indicate the order of display
      t.integer :order_of_display, default: 1
      
      t.text :note

      t.timestamps
    end
  end
end
