class AddNoteToUnitOfMeasurement < ActiveRecord::Migration
  def change
    add_column :unit_of_measurements, :note, :text
  end
end
