class AddMatchedColumnToGoals < ActiveRecord::Migration[7.1]
  def change
    add_column :goals, :matched, :boolean, default: false
  end
end
