require "application_system_test_case"

class SignUpTest < ApplicationSystemTestCase
  test "a visitor signs up and lands on the Lobby, signed in" do
    visit root_path
    click_on "Sign up"

    fill_in "Username", with: "Carol_7"
    fill_in "Email address", with: "carol@example.com"
    fill_in "Password", with: "correct horse"
    click_on "Sign up"

    assert_selector "h1", text: "Salon"
    within ".top-bar" do
      assert_text "Carol_7"
      assert_button "Se déconnecter"
    end
  end
end
