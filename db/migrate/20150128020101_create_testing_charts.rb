class CreateTestingCharts < ActiveRecord::Migration
  def change
    create_table :testing_charts, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :name, limit: 50
      t.integer :amount 
      t.string :x_label, limit: 50
      t.string :y_label, limit: 50

      t.timestamps
    end
  end
end
