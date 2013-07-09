require 'test_helper'

feature 'Viewing Library Feature Test' do
  before do
    @user = FactoryGirl.create :user, password: 'password'
    signin @user
  end

  scenario 'it only displays my book shelves' do
    other = FactoryGirl.create :other_user
    shelf1 = BookShelf.create(name: 'Non-Fiction', user_id: @user.id)
    shelf2 = BookShelf.create(name: 'Business', user_id: other.id)
    visit library_path
    page.must_have_content 'Non-Fiction'
    page.wont_have_content 'Business'
  end
end
