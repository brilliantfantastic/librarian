module Authentication
  module Helpers
    def signin(user, password = 'password')
      page.driver.post sessions_path, {
        user: { email: user.email, password: password }
      }
    end
  end
end
