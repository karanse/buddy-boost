class AddLastNameColumnToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :last_name, :string
  end
end
