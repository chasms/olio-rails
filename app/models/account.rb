class Account < ApplicationRecord
  # Active Record associations
  has_many :creations

  # email validations
  before_save { self.email = email.downcase }
  validates :email, presence: true, uniqueness: true,
  format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }

  # username validations
  before_save { self.username = username.downcase }
  validates :username, presence: true, uniqueness: true,
  format: { without: /\s/ }

  # password validations
  has_secure_password
  validates :password, presence: true, length: {minimum: 6}

end
