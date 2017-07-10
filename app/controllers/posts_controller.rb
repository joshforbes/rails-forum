class PostsController < ApplicationController
  skip_before_action :authenticate!, only: [:index, :show]

  def index
    posts = Post.all

    render json: posts
  end

  def show
    post = Post.find(params[:id])

    render json: post
  end

  def create
    post = Post.new(post_params.merge(user_id: current_user.id))

    if post.save
      render json: post, status: :created
    else
      render json: post.errors, status: :unprocessable_entity
    end
  end

  def update
    post = Post.find(params[:id])
    authorize post

    if post.update(post_params)
      render json: post
    else
      render json: post.errors, status: :unprocessable_entity
    end
  end

  def destroy
    post = Post.find(params[:id])
    authorize post

    post.destroy

    head :no_content
  end

  private
    def post_params
      params.require(:post).permit(:title, :body)
    end
end
