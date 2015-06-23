class AddFieldsToDistributions < ActiveRecord::Migration
  def change
    unless column_exists? :distributions, :to_nursery
      add_column :distributions, :to_nursery, :boolean, default: 0
    end
    unless column_exists? :distributions, :to_finish
      add_column :distributions, :to_finish, :boolean, default: 0
    end
  end
end
