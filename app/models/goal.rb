class Goal < ApplicationRecord
  belongs_to :user
  has_one :match
  validates :category, :description, presence: true
end
