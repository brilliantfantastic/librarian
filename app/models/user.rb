class User < ActiveRecord::Base
  authenticates_with_sorcery!
  attr_accessible :email, :password, :password_confirmation, :username

  validates :email, uniqueness: true,
    format: { with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/ }
  validates :password, presence: true, confirmation: true, if: :password
  validates :username, presence: true, uniqueness: true
end
