require 'test_helper'

feature 'Creating A BookShelf Feature Test' do
  before do
    @user = FactoryGirl.create :user, password: 'password'
    signin @user
    visit new_shelf_path
  end

  scenario 'creating a book shelf with valid data' do
    fill_in 'Name', with: 'Fiction'
    click_on 'Create Book shelf'

    shelf = BookShelf.last
    shelf.name.must_equal 'Fiction'
    shelf.user_id.must_equal @user.id
  end

  scenario 'submitting an empty form' do
    fill_in 'Name', with: ''
    click_on 'Create Book shelf'

    BookShelf.count.must_equal 0
    current_path.must_equal '/shelves'
    page.must_have_content "Name can't be blank"
  end

  describe 'while staying on the same page' do
    self.use_transactional_fixtures = false

    before do
      visit library_path
    end

    after(:each) do
      User.destroy_all
      BookShelf.destroy_all
    end

    scenario 'creating a shelf with valid data', js: true do
      click_link 'Add bookshelf'
      within '#new_book_shelf' do
        fill_in 'book_shelf_name', with: 'Fantasy'
        page.find('#book_shelf_name').native.send_keys :return
      end
      sleep 1
      new_shelf = BookShelf.last
      current_path.must_equal library_path
      page.must_have_content new_shelf.name
    end
  end
end
