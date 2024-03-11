class ChangeMatchStatusDefault < ActiveRecord::Migration[7.1]
  def change
    change_column_default :matches, :status, from: nil, to: "in progress"
  end
end
