class CreateOutputDistributions < ActiveRecord::Migration
  def change
    create_table :output_distributions, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :output_task_id, null: false
      t.string :distribution_id, null: false
      t.string :unit_measure_id, null: false
      t.float :amount, default: 0

      t.timestamps
    end
  end
end
