class CreateMaterialCategories < ActiveRecord::Migration
  def change
    create_table :material_categories, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :name, limit: 50, null: false

      t.timestamps
    end
  end
end
