class RolifyCreateRoles < ActiveRecord::Migration
  def change
    create_table :roles, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :name
      t.string :resource_id, limit: 36
      t.string :resource_type

      t.timestamps
    end

    create_table :users_roles, id: false do |t|
      t.string :user_id, limit: 36, null: false
      t.string :role_id, limit: 36, null: false
    end

    add_index(:roles, :name)
    add_index(:roles, [ :name, :resource_type, :resource_uuid ])
    add_index(:users_roles, [ :user_uuid, :role_uuid ])
  end
end
