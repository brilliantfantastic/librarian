require 'test_helper'

describe 'Book Cover Upload Feature Test' do
  let(:user) { FactoryGirl.create :user, password: 'password' }
  let(:shelf) { FactoryGirl.create :book_shelf, user: user }

  before { signin user, 'password' }

  scenario 'uploading a book cover when creating a book' do
    visit new_shelf_book_path(shelf)
    within('#new_book') do
      fill_in 'Book Name', with: 'Inferno'
      fill_in 'ISBN', with: '0385537859'
      attach_file 'Cover', Rails.root.join('test', 'fixtures', 'inferno.jpg')
      click_on 'Create Book'
    end

    current_path.must_ shelf_book_path(shelf, Book.last)
    page.must_have_xpath "//img[@src='public/uploads/inferno.jpg']"
  end
end
