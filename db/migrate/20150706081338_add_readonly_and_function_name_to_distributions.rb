class AddReadonlyAndFunctionNameToDistributions < ActiveRecord::Migration
  def change
    unless column_exists? :distributions, :read_only
      add_column :distributions, :read_only, :boolean, default: 0
    end
    unless column_exists? :distributions, :function_name
      add_column :distributions, :function_name, :string
    end
  end
end
