require 'test_helper'

class CommentsTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    comment = create(:comment)

    get post_comments_url(comment.post_id), as: :json

    assert_response :success
    assert_equal comment.id, json_response.first['id']
  end

  test 'should show comment' do
    comment = create(:comment)

    get comment_url(comment), as: :json

    assert_response :success
    assert_equal CommentSerializer.new(comment).to_json, response.body
  end

  test 'should create comment' do
    post = create(:post)
    user = post.user

    assert_difference('Comment.count') do
      post post_comments_url(post), params: {
          comment: {
              body: 'A new comment'
          }
      }, as: :json, headers: { 'AUTHORIZATION': user.token }
    end

    assert_response 201
    assert_not_nil(Comment.where(user_id: user.id, post_id: post.id, body: 'A new comment').first)
  end

  test 'should update comment' do
    comment = create(:comment)

    patch comment_url(comment), params: {
        comment: {
            body: 'Update comment',
        }
    }, as: :json, headers: { 'AUTHORIZATION': comment.user.token }

    assert_response 200
    assert_equal('Update comment', comment.reload.body)
  end

  test 'should destroy comment' do
    comment = create(:comment)

    assert_difference('Comment.count', -1) do
      delete comment_url(comment), as: :json, headers: { 'AUTHORIZATION': comment.user.token }
    end

    assert_response 204
  end
end
