require "test_helper"

class TopBarTest < ActionDispatch::IntegrationTest
  test "a signed-in page has a top bar with the brand, the User and Se déconnecter" do
    sign_in_as users(:alice)

    get root_path

    assert_select "header.top-bar" do
      assert_select ".top-bar__brand", "Belote"
      assert_select ".top-bar__user", /alice/
      assert_select ".avatar", "A"
      assert_select "form[action=?] button", session_path, "Se déconnecter"
    end
    assert_not_includes response.body, users(:alice).email_address
  end

  test "the auth pages have no top bar" do
    get new_session_path

    assert_select "header.top-bar", count: 0
  end
end
