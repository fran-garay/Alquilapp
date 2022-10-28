require "test_helper"

class AutosControllerTest < ActionDispatch::IntegrationTest
  test "should get listadoDeAutos" do
    get autos_listadoDeAutos_url
    assert_response :success
  end
end
