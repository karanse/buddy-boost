class Match < ApplicationRecord
  belongs_to :goal
  belongs_to :matched_goal, class_name: 'Goal'
  has_many :tasks
end
