class Contact < ApplicationRecord
    validates :name,    presence: true
    validates :email,   presence: true, format: /\A[^@\s]+@[^@\s]+\z/
    validates :subject, presence: true
    validates :body,    presence: true, length: { minimum: 10 }
end
