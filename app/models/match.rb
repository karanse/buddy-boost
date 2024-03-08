class Match < ApplicationRecord
  STATUSES = ["in progress", "completed", "cancelled"]

  belongs_to :goal
  belongs_to :matched_goal, class_name: 'Goal'
  has_many :tasks

  def other(current_user)
    id = matched_goal.user.id == current_user.id ? goal.id : matched_goal.id
    Goal.find(id)
  end
  
end
