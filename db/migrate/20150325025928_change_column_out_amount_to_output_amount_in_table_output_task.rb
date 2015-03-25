class ChangeColumnOutAmountToOutputAmountInTableOutputTask < ActiveRecord::Migration
  def change
    if column_exists? :output_tasks, :updated_by
      change_column :output_tasks, :updated_by, :string, limit: 36, null: true
    end 
    if column_exists? :output_tasks, :out_amount
      rename_column :output_tasks, :out_amount, :output_amount
    end 
  end
end
