require 'test_helper'

feature 'Sign Out Feature Test' do
  before do
    signin FactoryGirl.create(:user)
    visit root_path
  end

  scenario 'signing out clears the current user' do
    click_link 'Sign out'
    current_path.must_equal signin_path
    page.wont_have_content 'Sign out'
  end
end
