require 'test_helper'

class SessionsTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
  end

  test 'should authenticate the user and return their token' do
    post sessions_url, params: {
        user: {
            email: @user.email,
            password: @user.password
        }
    }, as: :json

    assert_response 200
    assert_equal @user.token, json_response['token']
  end

  test 'should destroy the current users token' do
    delete sessions_url, as: :json, headers: { 'AUTHORIZATION': @user.token }

    assert_response 204
    assert_nil @user.reload.token
  end
end
