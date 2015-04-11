class AddColumnsToTableOuputUserMachineries < ActiveRecord::Migration
  def change
    unless column_exists? :output_use_machineries, :warehouse_id
      add_column :output_use_machineries, :warehouse_id, :string, limit: 36
    end

    unless column_exists? :output_use_machineries, :material_id
      add_column :output_use_machineries, :material_id, :string, limit: 36
    end

    unless column_exists? :output_use_machineries, :material_amount
      add_column :output_use_machineries, :material_amount, :string, limit: 36
    end
  end
end
