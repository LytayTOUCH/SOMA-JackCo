class CreateResourceUsers < ActiveRecord::Migration
  def change
    create_table :resource_users, id: false do |t|
      t.string :resource_id
      t.string :user_id

      t.timestamps
    end
  end
end
