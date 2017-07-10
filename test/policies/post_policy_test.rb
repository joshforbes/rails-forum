require 'test_helper'

class PostPolicyTest < ActiveSupport::TestCase
  test 'the user that created the post is authorized to update it' do
    user = build(:user, id: 1)
    post = build(:post, user_id: 1)

    assert PostPolicy.new(user, post).update?
  end

  test 'a user cannot update another users post' do
    user = build(:user, id: 1)
    post = build(:post, user_id: 2)

    refute PostPolicy.new(user, post).update?
  end

  test 'the user that created the post is authorized to delete it' do
    user = build(:user, id: 1)
    post = build(:post, user_id: 1)

    assert PostPolicy.new(user, post).destroy?
  end

  test 'a user cannot delete another users post' do
    user = build(:user, id: 1)
    post = build(:post, user_id: 2)

    refute PostPolicy.new(user, post).destroy?
  end
end
