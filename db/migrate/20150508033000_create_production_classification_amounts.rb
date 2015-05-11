class CreateProductionClassificationAmounts < ActiveRecord::Migration
  def change
    create_table :production_classification_amounts, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :production_plan_id, limit: 36, null: false
      t.string :production_classification_id, limit: 36, null: false
      t.float :amount

      t.timestamps
    end
  end
end
