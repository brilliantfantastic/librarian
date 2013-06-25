require 'test_helper'

feature 'Sign Up Feature Test' do
  def create_user(user_hash)
    within('#new_user') do
      fill_in 'Username', with: user_hash[:username]
      fill_in 'Email', with: user_hash[:email]
      fill_in 'Password', with: user_hash[:password]
      fill_in 'Confirm Password', with: user_hash[:confirmation]
      click_on 'Sign Up'
    end
  end

  before do
    User.delete_all
  end

  describe 'with valid data' do
    before do
      visit new_user_path
      create_user(username: 'dhh', email: 'dhh@example.com',
                  password: 'password', confirmation: 'password')
    end

    scenario 'it creates a user in the database' do
      dhh = User.last
      dhh.username.must_equal 'dhh'
      dhh.email.must_equal 'dhh@example.com'
    end

    scenario 'it redirects to the root of the site' do
      current_path.must_equal root_path
    end
  end

  describe 'with invalid data' do
    before do
      visit new_user_path
      create_user(username: 'dhh', email: 'dhh@example.com',
                  password: 'x', confirmation: 'y')
    end

    scenario 'it does not create a new user' do
      User.count.must_equal 0
    end

    scenario 'it displays the errors' do
      page.must_have_content "Password doesn't match confirmation"
    end

    scenario 'it re-renders the sign up form' do
      current_path.must_equal '/users'
    end
  end
end
