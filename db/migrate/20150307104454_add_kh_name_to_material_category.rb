class AddKhNameToMaterialCategory < ActiveRecord::Migration
  def change
    unless column_exists? :material_categories, :kh_name
      add_column :material_categories, :kh_name, :string, limit: 50, null: true
    end
  end
end
