
require 'test_helper'

class CreateArticleTest < ActionDispatch::IntegrationTest

  setup do
    @admin_user = User.create(username: "johndoe", email: "johndoe@example.com",
                              password: "password", admin: true)
    sign_in_as(@admin_user)

    # # set up category needed for article creation
    # post categories_path, params: { category: { name: "Sports"} }
  end

  test "get new article form and create article" do
    get "/articles/new"
    assert_response :success
    assert_difference 'Article.count', 1 do
      # save without assigned categories
      post articles_path, params: { article: { description: "Description", title: "title", category_ids: []} }
      assert_response :success
      p @response
    end
    # follow_redirect!
    # assert_response :success
    assert_match "title", response.body
  end

  # test "get new category form and reject invalid category submission" do
  #   get "/categories/new"
  #   assert_response :success
  #   assert_no_difference 'Category.count' do
  #     post categories_path, params: { category: { name: " "} }
  #   end
  #   assert_match "errors", response.body
  #   assert_select 'div.alert'
  #   assert_select 'h4.alert-heading'
  # end
end
