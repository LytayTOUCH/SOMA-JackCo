class AddUuidToTablePermission < ActiveRecord::Migration
  def change
    add_column :permissions, :uuid, :string, limit: 36, primary: true, null: false
  end
end
