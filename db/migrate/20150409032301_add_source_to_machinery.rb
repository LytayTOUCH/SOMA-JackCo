class AddSourceToMachinery < ActiveRecord::Migration
  def change
    unless column_exists? :machineries, :source
      add_column :machineries, :source, :string, default: "Own Project"
    end
  end
end
