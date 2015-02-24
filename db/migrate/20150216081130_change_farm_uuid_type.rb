class ChangeFarmUuidType < ActiveRecord::Migration
  def change
  	change_column :farms, :uuid, :string, limit: 36, primary: true, null: false
  end
end
