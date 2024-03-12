class ChangeStatusTypeTasks < ActiveRecord::Migration[7.1]
  def change
    change_column :tasks, :status, :boolean, using: 'status::boolean'
  end
end
