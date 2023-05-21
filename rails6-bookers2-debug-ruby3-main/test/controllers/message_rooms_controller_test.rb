require "test_helper"

class MessageRoomsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get message_rooms_create_url
    assert_response :success
  end

  test "should get show" do
    get message_rooms_show_url
    assert_response :success
  end
end
