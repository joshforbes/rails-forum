class User < ApplicationRecord
  has_secure_password
  has_secure_token :token

  validates :name, :email, :password, presence: true
  validates :name, :email, :token, uniqueness: true

  has_many :posts

  def regenerate_token
    self.token = self.class.generate_unique_secure_token
    self.save!(validate: false)

    self
  end
end
