class CreateTestingWithBarCharts < ActiveRecord::Migration
  def change
    create_table :testing_with_bar_charts, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :element, limit: 50
      t.float :amount 
      t.string :bar_color, limit: 50

      t.timestamps
    end
  end
end
