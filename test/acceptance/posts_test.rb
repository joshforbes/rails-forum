require 'test_helper'

class PostsTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    create(:post)

    get posts_url, as: :json
    assert_response :success
  end

  test 'should create post' do
    user = create(:user)

    assert_difference('Post.count') do
      post posts_url, params: {
          post: {
              user_id: user.id,
              title: 'Test post',
              body: 'This is a test post',
          }
      }, as: :json, headers: { 'AUTHORIZATION': user.token }
    end

    assert_response 201
  end

  test 'should show post' do
    post = create(:post)

    get post_url(post), as: :json
    assert_response :success
  end

  test 'should update post' do
    post = create(:post)

    patch post_url(post), params: {
        post: {
            body: post.body,
            title: post.title,
            user_id: post.user_id
        }
    }, as: :json, headers: { 'AUTHORIZATION': post.user.token }

    assert_response 200
  end

  test 'should destroy post' do
    post = create(:post)

    assert_difference('Post.count', -1) do
      delete post_url(post), as: :json, headers: { 'AUTHORIZATION': post.user.token }
    end

    assert_response 204
  end
end
