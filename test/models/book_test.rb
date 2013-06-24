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

  it 'is invalid if the name has already been taken' do
    Book.create(name: 'Nebraska', name_confirmation: 'Nebraska')
    book = Book.new(name: 'Nebraska', name_confirmation: 'Nebraska')
    book.valid?.must_equal false
  end

  describe 'with a name' do
    before do
      @book = Book.new(name: 'Frankenstein', name_confirmation: 'Frankenstein')
    end

    it 'is invalid if the ISBN contains letters' do
      @book.isbn = '01234A5678'
      @book.valid?.must_equal false
    end

    it 'is invalid if the ISBN is not 10 or 13 digits' do
      @book.isbn = '012345678' # 9
      @book.valid?.must_equal false

      @book.isbn = '10123456789' # 11
      @book.valid?.must_equal false

      @book.isbn = '120123456789' # 12
      @book.valid?.must_equal false

      @book.isbn = '12340123456789' # 14
      @book.valid?.must_equal false
    end

    it 'is valid if the ISBN is 10 or 13 digits' do
      @book.isbn = '0123456789'
      @book.valid?.must_equal true

      @book.isbn = '1230123456789'
      @book.valid?.must_equal true
    end
  end
end
