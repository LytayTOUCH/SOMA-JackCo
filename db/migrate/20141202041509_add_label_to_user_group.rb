class AddLabelToUserGroup < ActiveRecord::Migration
  def change
    add_column :user_groups, :label, :string
  end
end
