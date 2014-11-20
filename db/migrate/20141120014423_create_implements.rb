class CreateImplements < ActiveRecord::Migration
  def change
    create_table :implements, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :name, limit: 50, null: false
      t.date :year
      t.string :implement_type_uuid, limit: 36, null: false
      t.float :value
      t.boolean :own, default: false
      t.text :note

      t.timestamps
    end
  end
end
