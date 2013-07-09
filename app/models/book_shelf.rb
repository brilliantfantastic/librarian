class BookShelf < ActiveRecord::Base
  attr_accessible :name, :books, :user_id

  belongs_to :user
  has_many :books

  validates :name, presence: true
  validates :user, presence: true
end
