require 'test_helper'

describe 'A new', Book do
  it 'requires confirmation of name' do
    book = Book.new(name: 'x', name_confirmation: '')
    book.valid?.must_equal false

    book.name_confirmation = 'y'
    book.valid?.must_equal false

    book.name_confirmation = 'x'
    book.valid?.must_equal true
  end

  it 'is invalid if it has no name' do
    book = Book.new
    book.valid?.must_equal false

    book.name = 'x'
    book.name_confirmation = 'x'
    book.valid?.must_equal true
  end

  it 'is valid if it has a name, confirmation, and no ISBN' do
    book = Book.new(name: 'x', name_confirmation: 'x')
    book.valid?.must_equal true
  end

  it 'is invalid if the name has already been taken'
  it 'is invalid if the ISBN contains letters'
  it 'is invalid if the ISBN is not 10 or 13 characters'
  it 'is valid if the ISBN is 10 or 13 digits'
end
