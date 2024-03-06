class Match < ApplicationRecord
  STATUSES = ["in progress", "completed", "cancelled"]

  belongs_to :goal
  belongs_to :matched_goal, class_name: 'Goal'
  has_many :tasks
end
