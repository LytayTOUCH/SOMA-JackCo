class CreateImplementTypes < ActiveRecord::Migration
  def change
    create_table :implement_types, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :name, limit: 50, null: false
      t.text :note

      t.timestamps
    end
  end
end
