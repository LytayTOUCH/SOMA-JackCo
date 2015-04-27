class CreatePlanBlocks < ActiveRecord::Migration
  def change
    create_table :plan_blocks, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :plan_area_id, limit: 36, null: false
      t.string :block_id, limit: 36, null: false
      t.integer :tree_amount

      t.timestamps
    end
  end
end
