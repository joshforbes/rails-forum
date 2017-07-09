require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'it can regenerate the token' do
    user = create(:user)
    original_token = user.token

    user = user.regenerate_token

    assert_not_equal original_token, user.token
  end
end
