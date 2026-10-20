require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "a username has 3 to 20 characters" do
    assert_predicate build_user(username: "abc"), :valid?
    assert_predicate build_user(username: "a" * 20), :valid?

    assert_invalid build_user(username: ""), :username
    assert_invalid build_user(username: "ab"), :username
    assert_invalid build_user(username: "a" * 21), :username
  end

  test "a username has only letters, digits and underscores" do
    assert_predicate build_user(username: "Alex_99"), :valid?

    assert_invalid build_user(username: "al ex"), :username
    assert_invalid build_user(username: "alex!"), :username
    assert_invalid build_user(username: "al-ex"), :username
    assert_invalid build_user(username: "élodie"), :username
  end

  test "a username is trimmed and otherwise kept as typed" do
    assert_equal "Alex_99", build_user(username: "  Alex_99 ").username
  end

  test "a username is unique ignoring case" do
    assert_invalid build_user(username: "alice"), :username
    assert_invalid build_user(username: "ALICE"), :username
    assert_invalid build_user(username: " Alice "), :username
  end

  test "the database rejects a username that differs only by case" do
    assert_raises ActiveRecord::RecordNotUnique do
      build_user(username: "ALICE").save!(validate: false)
    end
  end

  test "downcases and strips email_address" do
    user = User.new(email_address: " DOWNCASED@EXAMPLE.COM ")
    assert_equal("downcased@example.com", user.email_address)
  end

  test "an email address is required and well formed" do
    assert_invalid build_user(email_address: ""), :email_address
    assert_invalid build_user(email_address: "carol"), :email_address
    assert_invalid build_user(email_address: "carol@"), :email_address
    assert_invalid build_user(email_address: "carol example@example.com"), :email_address
  end

  test "an email address is unique, with a readable error" do
    user = build_user(email_address: " Alice@Example.com ")

    assert_not user.valid?
    assert_equal [ "Email address has already been taken" ], user.errors.full_messages_for(:email_address)
  end

  test "a password has at least 8 characters, with no character-type rules" do
    assert_predicate build_user(password: "aaaaaaaa"), :valid?

    assert_invalid build_user(password: ""), :password
    assert_invalid build_user(password: "aaaaaaa"), :password
  end

  test "a password has at most 72 bytes" do
    assert_predicate build_user(password: "a" * 72), :valid?
    assert_predicate build_user(password: "é" * 36), :valid?

    assert_invalid build_user(password: "a" * 73), :password
    assert_invalid build_user(password: "é" * 37), :password
  end

  test "a password reset also needs at least 8 characters" do
    assert_not users(:alice).update(password: "short")
    assert users(:alice).update(password: "long enough")
  end

  private
    def build_user(**attributes)
      User.new(username: "carol", email_address: "carol@example.com", password: "password", **attributes)
    end

    def assert_invalid(user, attribute)
      assert_not user.valid?, "#{attribute} #{user.public_send(attribute).inspect} should be invalid"
      assert_predicate user.errors[attribute], :any?
    end
end
