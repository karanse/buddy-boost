class Match < ApplicationRecord
  belongs_to :goal
  belongs_to :user
  has_many :tasks
end
