class AddCancelReasonColumnsToMatches < ActiveRecord::Migration[7.1]
  def change
    add_column :matches, :cancel_reason, :string
  end
end
