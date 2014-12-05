class ChangeYearDataTypeInImplements < ActiveRecord::Migration
  def change
    change_column :implements, :year, :string, limit: 10
  end
end
