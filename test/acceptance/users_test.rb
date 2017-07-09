require 'test_helper'

class UsersTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
  end

  test 'should get index' do
    get users_url, as: :json, headers: { 'AUTHORIZATION': @user.token }
    assert_response :success
  end

  test 'should create user' do
    assert_difference('User.count') do
      post users_url, params: {
          user: {
              name: 'Test User',
              email: 'test@user.com',
              password: 'Tester12'
          }
      }, as: :json
    end

    assert_response 201
  end

  test 'should show user' do
    get user_url(@user), as: :json
    assert_response :success
  end

  test 'should update user' do
    patch user_url(@user), params: { user: { email: @user.email, password: @user.password, token: @user.token } }, as: :json
    assert_response 200
  end

  test 'should destroy user' do
    assert_difference('User.count', -1) do
      delete user_url(@user), as: :json
    end

    assert_response 204
  end
end
