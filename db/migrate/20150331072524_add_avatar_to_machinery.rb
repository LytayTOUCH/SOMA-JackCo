class AddAvatarToMachinery < ActiveRecord::Migration
  def change
    add_attachment :machineries, :avatar
  end
end
