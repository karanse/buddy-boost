class AddChatroomRefToMatches < ActiveRecord::Migration[7.1]
  def change
    add_column :chatrooms, :match_id, :integer
    add_foreign_key :chatrooms, :matches, column: :match_id
  end
end
