class AddStatusColumnToGoals < ActiveRecord::Migration[7.1]
  def change
    add_column :goals, :status, :string, default: 'not_started'
  end
end
