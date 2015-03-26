class AlterLimitColumnStatusInTableProduction < ActiveRecord::Migration
  def change
    if column_exists? :productions, :status
      change_column :productions, :status, :string, limit: 50, null: false
    end  
  end
end
