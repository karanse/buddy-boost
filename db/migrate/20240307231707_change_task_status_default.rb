class ChangeTaskStatusDefault < ActiveRecord::Migration[7.1]
  def change
      change_column_default :tasks, :status, from: nil, to: false
  end
end
