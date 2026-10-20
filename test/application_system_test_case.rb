require "test_helper"
require "capybara/cuprite"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :cuprite, screen_size: [ 1400, 1000 ], options: { js_errors: true }

  private
    # Runs the block as the given User, in their own named browser session.
    # Signs them in through the real sign-in form whenever that session isn't signed in.
    def as(user)
      using_session(user.username) do
        sign_in_with_form user unless page.has_button?("Se déconnecter", wait: 0)
        yield
      end
    end

    # Every fixture User's password is "password".
    def sign_in_with_form(user)
      visit new_session_path
      fill_in "Enter your email address", with: user.email_address
      fill_in "Enter your password", with: "password"
      click_on "Sign in"

      assert_button "Se déconnecter"
    end
end
