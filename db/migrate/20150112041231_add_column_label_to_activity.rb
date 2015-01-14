class AddColumnLabelToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :label, :string
  end
end
