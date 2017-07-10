class User < ApplicationRecord
  has_secure_password
  has_secure_token :token

  validates :name, :email, presence: true
  validates :name, :email, :token, uniqueness: true
  validates :password, length: { minimum: 8 }, allow_nil: true

  has_many :posts
end
