require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'it can revoke the token' do
    user = create(:user)

    user = user.revoke_token

    assert_nil user.token
  end
end
