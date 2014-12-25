class EditDataTypeDateInActivity < ActiveRecord::Migration
  def change
    rename_column :activities, :date, :starts_at
    change_column :activities, :starts_at, :datetime
  end
end
