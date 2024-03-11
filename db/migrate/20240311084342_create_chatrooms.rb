class CreateChatrooms < ActiveRecord::Migration[7.1]
  def change
    create_table :chatrooms do |t|
      t.string :name
      t.references :sender, null: false
      t.references :receiver, null: false

      t.timestamps
    end
    add_foreign_key :chatrooms, :users, column: :sender_id
    add_foreign_key :chatrooms, :users, column: :receiver_id
  end
end
