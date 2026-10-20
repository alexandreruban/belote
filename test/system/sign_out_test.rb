require "application_system_test_case"

class SignOutTest < ApplicationSystemTestCase
  test "each User has their own browser and signs out from the top bar" do
    as(users(:alice)) do
      within(".top-bar") { assert_text "alice" }
    end

    as(users(:bob)) do
      within(".top-bar") { click_on "Se déconnecter" }
      assert_button "Sign in"
    end

    as(users(:alice)) do
      visit root_path
      within(".top-bar") { assert_text "alice" }
    end

    as(users(:bob)) do
      within(".top-bar") { assert_text "bob" }
    end
  end
end
