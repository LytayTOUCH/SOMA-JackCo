class AddTwoColumnToTableWarehouseMaterialReceived < ActiveRecord::Migration
  def change
    unless column_exists? :warehouse_material_receiveds, :created_by
      add_column :warehouse_material_receiveds, :created_by, :string, limit: 36, null: false
    end  
    unless column_exists? :warehouse_material_receiveds, :updated_by
      add_column :warehouse_material_receiveds, :updated_by, :string, limit: 36, null: false
    end  
  end
end
