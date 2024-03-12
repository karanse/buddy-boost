class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :photo, dependent: :destroy

  has_many :goals
  has_many :tasks
  has_many :matches, through: :goals
  has_many :sign_in_logs
  validates :first_name, :last_name, presence: true
end
