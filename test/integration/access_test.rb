require "test_helper"

class AccessTest < ActionDispatch::IntegrationTest
  PUBLIC_ACTIONS = %w[
    sessions#new sessions#create
    registrations#new registrations#create
    passwords#new passwords#create passwords#edit passwords#update
  ]

  test "the auth pages are public" do
    get new_session_path
    assert_response :success

    get new_registration_path
    assert_response :success

    get new_password_path
    assert_response :success

    get edit_password_path(users(:alice).password_reset_token)
    assert_response :success
  end

  test "every other page redirects to sign-in" do
    assert_includes app_routes.map { |verb, path, _| "#{verb} #{path}" }, "GET /"

    app_routes.each do |verb, path, action|
      next if action.in?(PUBLIC_ACTIONS)

      process verb.downcase.to_sym, path
      assert_redirected_to new_session_url, "#{verb} #{path} (#{action}) should need a signed-in User"
    end
  end

  test "sign-in links to sign-up and to the password reset" do
    get new_session_path

    assert_select "a[href=?]", new_registration_path
    assert_select "a[href=?]", new_password_path, text: "Forgot password?"
  end

  test "a signed-in User who opens sign-in or sign-up goes to the Lobby" do
    sign_in_as users(:alice)

    get new_session_path
    assert_redirected_to root_url

    get new_registration_path
    assert_redirected_to root_url
  end

  private
    # Every route served by one of the app's own controllers, as [verb, path with sample params, "controller#action"].
    def app_routes
      Rails.application.routes.routes.filter_map do |route|
        controller, action = route.defaults.values_at(:controller, :action)
        controller_class = "#{controller}_controller".camelize.safe_constantize

        if controller_class && controller_class < ApplicationController && controller_class.action_methods.include?(action)
          [ route.verb, route.path.spec.to_s.delete_suffix("(.:format)").gsub(/:\w+/, "1"), "#{controller}##{action}" ]
        end
      end
    end
end
