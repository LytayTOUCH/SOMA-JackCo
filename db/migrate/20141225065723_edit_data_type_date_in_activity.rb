class EditDataTypeDateInActivity < ActiveRecord::Migration
  def change
    if column_exists? :activities, :date
      rename_column :activities, :date, :starts_at
    end
    if column_exists? :activities, :starts_at
      change_column :activities, :starts_at, :datetime
    end
  end
end
