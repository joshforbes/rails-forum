require 'test_helper'

class CommentPolicyTest < ActiveSupport::TestCase
  test 'the user that created the comment is authorized to update it' do
    user = build(:user, id: 1)
    comment = build(:comment, user_id: 1)

    assert CommentPolicy.new(user, comment).update?
  end

  test 'a user cannot update another users comment' do
    user = build(:user, id: 1)
    comment = build(:comment, user_id: 2)

    refute CommentPolicy.new(user, comment).update?
  end

  test 'the user that created the comment is authorized to delete it' do
    user = build(:user, id: 1)
    comment = build(:comment, user_id: 1)

    assert CommentPolicy.new(user, comment).destroy?
  end

  test 'a user cannot delete another users comment' do
    user = build(:user, id: 1)
    comment = build(:comment, user_id: 2)

    refute CommentPolicy.new(user, comment).destroy?
  end
end
