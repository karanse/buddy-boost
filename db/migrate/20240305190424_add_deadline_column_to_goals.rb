class AddDeadlineColumnToGoals < ActiveRecord::Migration[7.1]
  def change
    add_column :goals, :deadline, :date
  end
end
