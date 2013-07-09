require 'test_helper'

describe BookShelf do
  it 'can have books added to it' do
    book_shelf = BookShelf.create
    book_shelf.books.must_be_empty

    book = Book.new(name: '10,000 Leagues Under the Sea')
    book_shelf.books << book
    book_shelf.books.must_equal [book]
  end

  it 'can have the user_id assigned' do
    user = FactoryGirl.create :user
    book_shelf = BookShelf.new(user_id: user.id)
    book_shelf.valid?.must_equal true
  end

  it 'is invalid without a user' do
    book_shelf = BookShelf.new
    book_shelf.valid?.must_equal false
    book_shelf.errors.full_messages.must_include "User can't be blank"
  end
end
