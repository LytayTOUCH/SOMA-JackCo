class CreateSuppliers < ActiveRecord::Migration
  def change
    create_table :suppliers, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :name, limit: 50, null: false
      t.string :contact_person, limit: 100
      t.string :phone, limit: 20
      t.string :email, limit: 100
      t.text :address
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
