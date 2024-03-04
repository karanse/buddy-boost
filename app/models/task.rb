class Task < ApplicationRecord
  belongs_to :match
  belongs_to :user
  belongs_to :goal, through: :match

  validates :description, presence: true
end
