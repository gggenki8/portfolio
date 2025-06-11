class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :skill_offering
  has_many   :messages, dependent: :destroy
  has_one    :review,   dependent: :destroy 

  enum status: { 
    pending:   "pending", 
    approved:  "approved", 
    rejected:  "rejected",
    completed: "completed",
    reviewed:  "reviewed", 
    cancelled: "cancelled"
  }

  # 追加カラム：完了時刻／レビュー時刻
  # t.datetime :completed_at
  # t.datetime :reviewed_at

  validates :reserved_date, presence: true
  validates :reserved_time, presence: true
  validates :message,       presence: true
  validates :status,        presence: true

  # 講師が「完了」ボタンを押せるか
  def can_mark_completed?
    approved? #テスト用
    # approved? && reserved_date < Date.today 本来の形
  end

  # 完了処理をまとめておく
  def mark_completed!
    update!(status: :completed, completed_at: Time.current)
  end

  # 生徒がレビューを書けるか
  def can_write_review?
    completed? && review.nil?
  end

  # レビュー保存後に呼び出してステータスを更新
  def mark_reviewed!
    update!(status: :reviewed, reviewed_at: Time.current)
  end
end
