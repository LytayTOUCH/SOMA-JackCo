class CreateOutputUseMachineries < ActiveRecord::Migration
  def change
    create_table :output_use_machineries, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :output_id, limit: 36, null: false
      t.string :machinery_id, limit: 36, null: false

      t.timestamps
    end
  end
end
