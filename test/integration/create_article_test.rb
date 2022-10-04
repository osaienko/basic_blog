require 'test_helper'

class CreateArticleTest < ActionDispatch::IntegrationTest

  setup do
    @admin_user = User.create(username: "johndoe", email: "johndoe@example.com",
                              password: "password", admin: true)
    sign_in_as(@admin_user)
  end

  test "get new article form and create article" do
    get "/articles/new"
    assert_response :success
    assert_difference 'Article.count', 1 do
      # save without assigned categories
      post articles_path, params: { article: { description: "Description", title: "title!", category_ids: []} }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "title", response.body
  end

  test "get new article form, validation for create article fails" do
    get "/articles/new"
    assert_response :success
    assert_difference 'Article.count', 0 do
      # save without assigned categories
      # title is 5 chars with allowed  >= 6
      post articles_path, params: { article: { description: "Description", title: "title", category_ids: []} }
      assert_response :success
    end
    # follow_redirect!
    # assert_response :success
    assert_match "Title is too short (minimum is 6 characters)", response.body
  end
end


