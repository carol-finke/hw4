class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  def authenticate(password)
    BCrypt::Password.new(self.password) == password
  end
end
