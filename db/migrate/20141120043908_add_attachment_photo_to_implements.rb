class AddAttachmentPhotoToImplements < ActiveRecord::Migration
  def self.up
    change_table :implements do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :implements, :photo
  end
end
