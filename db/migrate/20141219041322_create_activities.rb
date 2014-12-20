class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities, id: false do |t|
      t.string  :uuid, limit: 36, primary: true, null: false
      t.string  :name, limit: 100, null: false
      t.text    :note
      t.boolean :active, :boolean, default: true

      t.timestamps
    end
  end
end
