require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'a new user is not valid without a password' do
    user = User.new(password: nil)

    valid = user.valid?

    assert_equal false, valid
  end

  test 'a new user is not valid with a short password' do
    user = User.new(password: 'short')

    valid = user.valid?

    assert_equal false, valid
  end

  test 'a user is valid with no changes' do
    create(:user)
    user = User.first

    valid = user.valid?

    assert_equal true, valid
  end

  test 'an existing user is valid with a new (valid) password' do
    create(:user)
    user = User.first
    user.password = 'New Password'
    user.save!

    valid = user.valid?

    assert_equal true, valid
  end
end
