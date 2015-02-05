class AddLabelToActivityTypes < ActiveRecord::Migration
  def change
    add_column :activity_types, :label, :string
  end
end
