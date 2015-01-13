class AddFruitTypeFieldToStage < ActiveRecord::Migration
  def change
    add_column :stages, :fruit_type, :string
    change_column :stages, :period, :string, null: true
  end
end
