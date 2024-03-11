class Match < ApplicationRecord
  MATCH_STATUSES = ["in progress", "completed", "cancelled"]

  belongs_to :goal
  belongs_to :matched_goal, class_name: 'Goal'
  has_many :tasks
  has_one :chatroom

  def other(current_user)
    id = matched_goal.user.id == current_user.id ? goal.id : matched_goal.id
    Goal.find(id)
  end

  def set_status(status)
    self.update(status: status)
  end
end
