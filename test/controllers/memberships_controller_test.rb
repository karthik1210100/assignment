require "test_helper"

class MembershipsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get memberships_index_url
    assert_response :success
  end

  test "should get show" do
    get memberships_show_url
    assert_response :success
  end

  test "should get new" do
    get memberships_new_url
    assert_response :success
  end

  test "should get edit" do
    get memberships_edit_url
    assert_response :success
  end
end
