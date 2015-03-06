class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings, id: false do |t|
      t.string :code, null: false
      t.text :note, null: false
      t.string :valueType, null: false
      t.integer :valueInteger, default: nil
      t.string :valueString, default: nil
      t.float :valueFloat, default: nil
      
      t.timestamps
    end
  end
end
