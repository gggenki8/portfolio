class Message < ApplicationRecord
  belongs_to :reservation
  belongs_to :user

  validates :content, presence: true
end
