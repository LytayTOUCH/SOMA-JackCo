class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :name, limit: 100, null: false
      t.string :quantity, limit: 50, null: false
      t.string :unit, limit: 100, null: false
      t.string :year, limit: 10, null: false

      t.timestamps
    end
  end
end
