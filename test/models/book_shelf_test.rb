require 'test_helper'

describe BookShelf do
  it 'can have books added to it' do
    book_shelf = FactoryGirl.create :book_shelf
    book_shelf.books.must_be_empty

    book = Book.new(name: '10,000 Leagues Under the Sea')
    book_shelf.books << book
    book_shelf.books.must_equal [book]
  end

  it 'can have the user_id assigned' do
    user = FactoryGirl.create :user
    book_shelf = BookShelf.new(name: 'Historical', user_id: user.id)
    book_shelf.valid?.must_equal true
  end

  it 'is invalid without a user' do
    book_shelf = BookShelf.new(name: 'Historical')
    book_shelf.valid?.must_equal false
    book_shelf.errors.full_messages.must_include "User can't be blank"
  end

  it 'is invalid without a name' do
    book_shelf = FactoryGirl.build :book_shelf, name: ''
    book_shelf.valid?.must_equal false
    book_shelf.errors.full_messages.must_include "Name can't be blank"
  end

  describe '.for' do
    before do
      other = FactoryGirl.create :other_user
      @shelf1 = BookShelf.create(name: 'Childrens', user_id: other.id)
      @shelf2 = BookShelf.create(name: 'Adult', user_id: other.id)
    end

    it 'only returns the bookshelves owned by the user' do
      user = FactoryGirl.create :user
      user_shelf = FactoryGirl.create :book_shelf, user: user
      user_shelves = BookShelf.for(user)
      user_shelves.must_include user_shelf
      user_shelves.wont_include @shelf1
      user_shelves.wont_include @shelf2
    end
  end
end
