require 'test_helper'

feature 'Creating A BookShelf Feature Test' do
  before do
    @user = FactoryGirl.create :user, password: 'password'
    signin @user
    visit new_shelf_path
  end

  scenario 'creating a book shelf with valid data' do
    fill_in 'Name', with: 'Fiction'
    click_on 'Create Bookshelf'

    shelf = BookShelf.last
    shelf.name.must_equal 'Fiction'
    shelf.user_id.must_equal @user.id
  end

  scenario 'submitting an empty form' do
    fill_in 'Name', with: ''
    click_on 'Create Bookshelf'

    BookShelf.count.must_equal 0
    current_path.must_equal '/shelves'
    page.must_have_content "Name can't be blank"
  end
end
