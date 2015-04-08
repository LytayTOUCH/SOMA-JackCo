class AddAreaToBlock < ActiveRecord::Migration
  def change
  	unless column_exists? :blocks, :area
      add_column :blocks, :area, :string
    end
  end
end
