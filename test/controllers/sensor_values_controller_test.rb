require 'test_helper'

class SensorValuesControllerTest < ActionController::TestCase
  setup do
    @sensor_value = sensor_values(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sensor_values)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sensor_value" do
    assert_difference('SensorValue.count') do
      post :create, sensor_value: { value: @sensor_value.value }
    end

    assert_redirected_to sensor_value_path(assigns(:sensor_value))
  end

  test "should show sensor_value" do
    get :show, id: @sensor_value
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sensor_value
    assert_response :success
  end

  test "should update sensor_value" do
    patch :update, id: @sensor_value, sensor_value: { value: @sensor_value.value }
    assert_redirected_to sensor_value_path(assigns(:sensor_value))
  end

  test "should destroy sensor_value" do
    assert_difference('SensorValue.count', -1) do
      delete :destroy, id: @sensor_value
    end

    assert_redirected_to sensor_values_path
  end
end
