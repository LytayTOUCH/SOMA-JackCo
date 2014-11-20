class AddAttachmentPhotoToTractors < ActiveRecord::Migration
  def self.up
    change_table :tractors do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :tractors, :photo
  end
end
