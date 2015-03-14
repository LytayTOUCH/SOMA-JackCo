class ChangeColumnCreatedByandUpdatedByInTableWarehouseMaterialReceived < ActiveRecord::Migration
  def change
    if column_exists? :warehouse_material_receiveds, :created_by
      change_column :warehouse_material_receiveds, :created_by, :string, null: true, limit: 36
    end 

    if column_exists? :warehouse_material_receiveds, :updated_by
      change_column :warehouse_material_receiveds, :updated_by, :string, null: true, limit: 36
    end 
  end
end
