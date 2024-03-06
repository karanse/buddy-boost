class AddMatchedGoalIdToMatches < ActiveRecord::Migration[7.1]
  def change
    add_reference :matches, :matched_goal, foreign_key: { to_table: :goals }
  end
end
