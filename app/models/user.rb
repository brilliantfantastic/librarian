class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :username

  validates :email, uniqueness: true,
    format: { with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/ }
  validates :password, presence: true, confirmation: true
  validates :username, presence: true, uniqueness: true
end
