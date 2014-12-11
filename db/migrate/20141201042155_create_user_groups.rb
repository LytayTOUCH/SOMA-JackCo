class CreateUserGroups < ActiveRecord::Migration
  def change
    create_table :user_groups, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :name, limit: 50, null: false
      t.text :description 
      t.boolean :active, :boolean, default: true, null: false

      t.timestamps
    end
  end
end
