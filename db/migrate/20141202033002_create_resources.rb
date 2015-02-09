class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :name, limit: 50, null: false
      t.string :label, limit: 50
      t.text :note 
      t.boolean :active, default: true, null: false

      t.timestamps
    end
  end
end
