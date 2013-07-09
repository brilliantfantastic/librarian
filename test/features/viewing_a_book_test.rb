require 'test_helper'

feature 'Viewing A Book Feature Test' do
  before do
    @user = FactoryGirl.create :user, password: 'password'
    @other_user = FactoryGirl.create :other_user, password: 'password'
    @shelf = FactoryGirl.create :book_shelf, user: @user
    @book = FactoryGirl.create :book
    @shelf.books << @book
  end

  scenario 'Attempting to view a book on a shelf you own' do
    signin @user, 'password'
    visit shelf_book_path(@shelf, @book)
    page.must_have_content @book.name
    page.must_have_content @book.isbn
  end

  scenario "404 when Attempting to view a book on another user's shelf" do
    signin @other_user, 'password'
    visit shelf_book_path(@shelf, @book)
    page.status_code.must_equal 404
    page.wont_have_content @book.name
    page.wont_have_content @book.isbn
  end

  scenario "404 when Attempting to view a book that isn't on the shelf" do
    book2 = Book.create(name: 'The Joy of Cooking', isbn: '9780451195159')
    signin @user, 'password'
    visit shelf_book_path(@shelf, book2)
    page.status_code.must_equal 404
    page.wont_have_content book2.name
    page.wont_have_content book2.isbn
  end
end
