class User < ApplicationRecord
  has_secure_password
  has_secure_token :token

  validates :name, :email, :password, presence: true
  validates :name, :email, :token, uniqueness: true

end
