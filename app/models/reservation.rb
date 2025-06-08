class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :skill_offering
  has_many   :messages, dependent: :destroy
  has_one    :review, dependent: :destroy 

  enum status: { 
    pending:   "pending", 
    approved:  "approved", 
    rejected:  "rejected",
    completed: "completed",
    reviewed:  "reviewed", 
    cancelled: "cancelled"
  }

  validates :reserved_date,  presence: true
  validates :reserved_time,  presence: true

  def can_mark_completed?
    approved? #テスト用
    # approved? && reserved_date < Date.today 本来の形
  end

end
