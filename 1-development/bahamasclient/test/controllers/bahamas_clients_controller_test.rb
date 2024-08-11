require "test_helper"

class BahamasClientsControllerTest < ActionDispatch::IntegrationTest
  test "should get store" do
    get bahamas_clients_store_url
    assert_response :success
  end

  test "should get retrieve" do
    get bahamas_clients_retrieve_url
    assert_response :success
  end
end
