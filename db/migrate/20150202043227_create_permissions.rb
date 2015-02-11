class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions, id: false do |t|
      t.string :name, limit: 50
      t.string :user_group_id
      t.string :resource_id
      t.boolean :access_list, default: false
      t.boolean :access_create, default: false
      t.boolean :access_update, default: false
      t.boolean :access_delete, default: false
      t.boolean :access_full, default: false
      t.boolean :active, default: true, null: false
      t.timestamps
    end
  end
end
