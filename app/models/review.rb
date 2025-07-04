class Review < ApplicationRecord
  belongs_to :reservation
  belongs_to :user

  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :comment, presence: true
end
