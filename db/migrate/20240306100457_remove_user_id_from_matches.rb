class RemoveUserIdFromMatches < ActiveRecord::Migration[7.1]
  def change
    remove_column :matches, :user_id
  end
end
