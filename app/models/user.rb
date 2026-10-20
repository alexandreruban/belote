class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :username, with: ->(u) { u.strip }
  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :username, presence: true
  validates :username, length: { in: 3..20 }, format: { with: /\A[A-Za-z0-9_]+\z/, message: "can only use letters, digits and underscores" }, allow_blank: true
  validates :username, uniqueness: { case_sensitive: false }

  validates :email_address, presence: true
  validates :email_address, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
  validates :email_address, uniqueness: true

  validates :password, length: { minimum: 8 }, allow_nil: true
end
