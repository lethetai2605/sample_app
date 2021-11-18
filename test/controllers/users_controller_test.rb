require 'test_helper'
# frozen_string_literal: true
class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get signup_path
    assert_response :success
  end
end
