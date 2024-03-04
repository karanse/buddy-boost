class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :goals
  has_many :tasks
  has_many :matches

  has_many :received_matches, through: :goals, source: :user
  validates :first_name, :last_name, presence: true
end
