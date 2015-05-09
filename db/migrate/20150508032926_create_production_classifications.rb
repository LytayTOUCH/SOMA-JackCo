class CreateProductionClassifications < ActiveRecord::Migration
  def change
    create_table :production_classifications, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :name
      t.string :planting_project_id, limit: 36, null: false

      t.timestamps
    end

  end
end
