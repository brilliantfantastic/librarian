class Book < ActiveRecord::Base
  attr_accessible :cover_url, :isbn, :name, :name_confirmation

  belongs_to :book_shelf

  validates :name, confirmation: true, presence: true, uniqueness: true
  validates :isbn, format: { with: /^([0-9]{10}|[0-9]{13})$/ },
                   allow_nil: true
end
