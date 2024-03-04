class Goal < ApplicationRecord
  belongs_to :user
  has_one :match

  has_many :tasks, through: :matches
  validates :category, :description, presence: true
end
