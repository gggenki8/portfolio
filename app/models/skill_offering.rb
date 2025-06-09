class SkillOffering < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true

  has_many :reservations, dependent: :destroy
  has_many :reviews, through: :reservations

  validates :category_id,      presence: true
  validates :available_time,   presence: true, length: { maximum: 100 }
  validates :details,          presence: true, length: { minimum: 10 }
 
end
