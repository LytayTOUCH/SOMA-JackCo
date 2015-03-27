class AddAvailabilityAndAvailableDateToMachinery < ActiveRecord::Migration
  def change
    unless column_exists? :machineries, :availability
      add_column :machineries, :availability, :string, default: "Ready To Use"
    end
    
    unless column_exists? :machineries, :availabe_date
      add_column :machineries, :availabe_date, :date, default: Date.today
    end
    
    unless column_exists? :machineries, :warehouse_id
      add_column :machineries, :warehouse_id, :string, limit: 36, null: true 
    end
  end
end
