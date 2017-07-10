require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'a new user is not valid without a password' do
    user = User.new(password: nil)

    refute user.valid?
  end

  test 'a new user is not valid with a short password' do
    user = User.new(password: 'short')

    refute user.valid?
  end

  test 'a user is valid with no changes' do
    create(:user)
    user = User.first

    assert user.valid?
  end

  test 'an existing user is valid with a new (valid) password' do
    create(:user)
    user = User.first
    user.password = 'New Password'
    user.save!

    assert user.valid?
  end
end
