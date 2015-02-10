class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions, id: false do |t|
      t.string :name, limit: 50
      t.string :user_group_id
      t.string :resource_id
      t.boolean :access_list
      t.boolean :access_create
      t.boolean :access_update
      t.boolean :access_delete
      t.boolean :access_full
      t.boolean :active, default: true, null: false
      t.timestamps
    end
  end
end
