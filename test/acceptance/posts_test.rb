require 'test_helper'

class PostsTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    post = create(:post)

    get posts_url, as: :json

    assert_response :success
    assert_equal post.id, json_response.first['id']
  end

  test 'should show post' do
    post = create(:post)

    get post_url(post), as: :json

    assert_response :success
    assert_equal PostSerializer.new(post).to_json, response.body
  end

  test 'should create a post for the current user' do
    user = create(:user)

    assert_difference('Post.count') do
      post posts_url, params: {
          post: {
              title: 'Test post',
              body: 'This is a test post',
          }
      }, as: :json, headers: { 'AUTHORIZATION': user.token }
    end

    assert_response 201
    assert_not_nil(Post.where(user_id: user.id, title: 'Test post', body: 'This is a test post').first)
  end

  test 'should update post' do
    post = create(:post)

    patch post_url(post), params: {
        post: {
            title: 'New title',
            body: 'New content',
        }
    }, as: :json, headers: { 'AUTHORIZATION': post.user.token }

    post.reload

    assert_response 200
    assert_equal('New title', post.title)
    assert_equal('New content', post.body)
  end

  test 'should destroy post' do
    post = create(:post)

    assert_difference('Post.count', -1) do
      delete post_url(post), as: :json, headers: { 'AUTHORIZATION': post.user.token }
    end

    assert_response 204
  end
end
