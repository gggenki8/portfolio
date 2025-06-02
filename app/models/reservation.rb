class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :skill_offering

  enum status: { pending: 0, approved: 1, rejected: 2 }

  validates :reserved_date,  presence: true
  validates :reserved_time,  presence: true

end
