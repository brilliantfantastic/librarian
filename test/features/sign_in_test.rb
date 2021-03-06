require 'test_helper'

feature 'Sign In Feature Test' do
  scenario 'signing in with a valid email and password' do
    user = FactoryGirl.create :user, password: 'hampster'
    visit signin_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'hampster'
    click_button 'Sign In'

    current_path.must_equal library_path
    page.must_have_content "Welcome #{user.username}"
  end

  scenario 'signing in with incorrect email or password' do
    user = FactoryGirl.create :user, password: 'testing123'
    visit signin_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'p@ssword'
    click_button 'Sign In'

    current_path.must_equal '/sessions'
    page.must_have_content "Invalid email or password"
  end
end
