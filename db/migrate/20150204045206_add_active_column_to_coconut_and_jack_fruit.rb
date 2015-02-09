class AddActiveColumnToCoconutAndJackFruit < ActiveRecord::Migration
  def change
    add_column :coconuts, :active, :boolean, default: true
    add_column :jack_fruits, :active, :boolean, default: true
  end
end
