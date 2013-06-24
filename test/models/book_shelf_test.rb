require 'test_helper'

describe BookShelf do
  it 'can have books added to it' do
    book_shelf = BookShelf.create
    book_shelf.books.must_be_empty

    book = Book.new(name: '10,000 Leagues Under the Sea')
    book_shelf.books << book
    book_shelf.books.must_equal [book]
  end
end
