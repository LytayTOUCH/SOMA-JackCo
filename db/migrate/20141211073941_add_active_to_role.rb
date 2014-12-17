class AddActiveToRole < ActiveRecord::Migration
  def change
    add_column :roles, :active, :boolean, dault: :true
  end
end
