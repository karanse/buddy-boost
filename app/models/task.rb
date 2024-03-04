class Task < ApplicationRecord
  belongs_to :match
  belongs_to :user

  validates :description, presence: true
end
