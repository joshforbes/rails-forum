require 'test_helper'

class UsersTest < ActionDispatch::IntegrationTest
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
    assert_not_nil(User.where(name: 'Test user', email: 'test@user.com').first)
  end

  test 'should update user' do
    user = create(:user)

    patch user_url(user), params: {
        user: {
            name: 'New name',
            email: 'new@email.com',
            password: 'newPassword',
        }
    }, as: :json, headers: { 'AUTHORIZATION': user.token }

    user.reload

    assert_response 200
    assert_equal('New name', user.name)
    assert_equal('new@email.com', user.email)
  end
end
