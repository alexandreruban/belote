require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "new" do
    get new_registration_path
    assert_response :success
  end

  test "create signs the new User in and lands on the Lobby" do
    assert_difference -> { User.count } do
      post registration_path, params: { user: { username: " Carol_7 ", email_address: "Carol@Example.com", password: "password" } }
    end

    assert_redirected_to root_path
    assert cookies[:session_id]

    follow_redirect!
    assert_response :success
    assert_select "h1", "Salon"
  end

  test "create with invalid details shows the form again with an error next to each field" do
    assert_no_difference -> { User.count } do
      post registration_path, params: { user: { username: "al", email_address: "alice", password: "short" } }
    end

    assert_response :unprocessable_content
    assert_nil cookies[:session_id]
    assert_select ".field:has(#user_username) .field-error", "Username is too short (minimum is 3 characters)"
    assert_select ".field:has(#user_email_address) .field-error", "Email address is invalid"
    assert_select ".field:has(#user_password) .field-error", "Password is too short (minimum is 8 characters)"
  end

  test "create with a taken username or email address" do
    post registration_path, params: { user: { username: "ALICE", email_address: "alice@example.com", password: "password" } }

    assert_response :unprocessable_content
    assert_select ".field:has(#user_username) .field-error", "Username has already been taken"
    assert_select ".field:has(#user_email_address) .field-error", "Email address has already been taken"
    assert_select ".field:has(#user_password) .field-error", count: 0
  end
end
