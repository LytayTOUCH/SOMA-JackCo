class AddNoteToMaterialCategories < ActiveRecord::Migration
  def change
    add_column :material_categories, :note, :text
  end
end
