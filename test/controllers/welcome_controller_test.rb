require "test_helper"

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_url
    assert_response :success
    assert_select "h2", "Hello World"
    assert_select "p", /The time is now:/
  end

  # test "the truth" do
  #   assert true
  # end
end
