require "test_helper"

class LessonsControllerTest < ActionDispatch::IntegrationTest
  test "should get hello" do
    get lessons_hello_url
    assert_response :success
  end
end
