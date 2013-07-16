require 'test_helper'

describe 'Book Cover Upload Feature Test' do
  let(:user) { FactoryGirl.create :user, password: 'password' }
  let(:shelf) { FactoryGirl.create :book_shelf, user: user }
  let(:upload_path) { Rails.root.join('public', 'uploads', 'inferno.jpg') }

  before { signin user, 'password' }
  after { FileUtils.rm(upload_path) }

  scenario 'uploading a book cover when creating a book' do
    visit new_shelf_book_path(shelf)
    within('#new_book') do
      fill_in 'Book Name', with: 'Inferno'
      fill_in 'ISBN', with: '0385537859'
      attach_file 'Cover', Rails.root.join('test', 'fixtures', 'inferno.jpg')
      click_on 'Create Book'
    end

    current_path.must_equal shelf_book_path(shelf, Book.last)
    page.must_have_xpath "//img[@src='/uploads/inferno.jpg']"
  end
end
