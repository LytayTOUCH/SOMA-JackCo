class AddNoteToTransactionStatus < ActiveRecord::Migration
  def change
    add_column :transaction_statuses, :note, :text
  end
end
