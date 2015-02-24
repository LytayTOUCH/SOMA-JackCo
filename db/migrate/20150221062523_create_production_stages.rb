class CreateProductionStages < ActiveRecord::Migration
  def change
    create_table :production_stages, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :name, limit: 50, null: false
      t.boolean :active, default: true 
      t.text :note

      t.timestamps
    end
  end
end
