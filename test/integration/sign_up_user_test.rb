require 'test_helper'

class SignUpUserTest < ActionDispatch::IntegrationTest

  USER_NAME = "roza.diaz"

  test "get sign up form and register new user" do
    get "/signup"
    assert_response :success
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { username: USER_NAME, email: "roza@99.com", password: "pimento"} }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success

    assert_match "Welcome to the Basic BLOG #{USER_NAME}, you have successfully signed up", response.body
  end

  # TODO: Tests for the following validation errors:
  #   Email has already been taken
  #   Password can't be blank
  #   Username has already been taken
end




