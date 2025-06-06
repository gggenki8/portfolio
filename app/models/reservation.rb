class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :skill_offering

  enum status: { pending: "pending", approved: "approved", rejected: "rejected" }

  has_many :messages, dependent: :destroy
  
  validates :reserved_date,  presence: true
  validates :reserved_time,  presence: true

end
