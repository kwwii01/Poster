class RemoveStatusFromComments < ActiveRecord::Migration[6.1]
  def change
    remove_column :comments, :status
  end
end
