class CreateProcessPlanSchedules < ActiveRecord::Migration
  def change
    create_table :process_plan_schedules, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :process_plan_id, limit: 36, null: false
      t.string :app_id, limit: 36, null: false
      t.string :app_description_id, limit: 36, null: false
      t.boolean :jan, default: false
      t.boolean :feb, default: false
      t.boolean :mar, default: false
      t.boolean :apr, default: false
      t.boolean :may, default: false
      t.boolean :jun, default: false
      t.boolean :jul, default: false
      t.boolean :aug, default: false
      t.boolean :sep, default: false
      t.boolean :oct, default: false
      t.boolean :nov, default: false
      t.boolean :dec, default: false

      t.timestamps
    end
  end
end
