module Authentication
  module Helpers
    def signin(user, password = 'password')
      if Capybara.current_driver == :rack_test
        page.driver.post sessions_path, {
          user: { email: user.email, password: password }
        }
      else
        fill_in_sign_in(user, password)
      end
    end

    def basic_auth(user, password)
      request.env['HTTP_AUTHORIZATION'] =
        "Basic " + Base64::encode64("#{user.email}:#{password}")
    end

    def fill_in_sign_in(user, password)
      visit signin_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: password
      click_button 'Sign In'
    end
  end
end
