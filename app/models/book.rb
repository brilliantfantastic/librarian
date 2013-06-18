class Book < ActiveRecord::Base
  attr_accessible :isbn, :name, :name_confirmation

  validates :name, confirmation: true
end
