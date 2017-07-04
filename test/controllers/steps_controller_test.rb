require 'test_helper'

class StepsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @step = steps(:one)
  end

  test "should get index" do
    get steps_url
    assert_response :success
  end

  test "should get new" do
    get new_step_url
    assert_response :success
  end

  test "should create step" do
    assert_difference('Step.count') do
      post steps_url, params: { step: { finished: @step.finished, game_id: @step.game_id, name: @step.name } }
    end

    assert_redirected_to step_url(Step.last)
  end

  test "should show step" do
    get step_url(@step)
    assert_response :success
  end

  test "should get edit" do
    get edit_step_url(@step)
    assert_response :success
  end

  test "should update step" do
    patch step_url(@step), params: { step: { finished: @step.finished, game_id: @step.game_id, name: @step.name } }
    assert_redirected_to step_url(@step)
  end

  test "should destroy step" do
    assert_difference('Step.count', -1) do
      delete step_url(@step)
    end

    assert_redirected_to steps_url
  end
end
