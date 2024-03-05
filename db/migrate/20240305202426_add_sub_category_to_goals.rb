class AddSubCategoryToGoals < ActiveRecord::Migration[7.1]
  def change
    add_column :goals, :sub_category, :string
  end
end
