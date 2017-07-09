class CommentsController < ApplicationController
  skip_before_action :authenticate!, only: [:index, :show]

  def index
    comments = Comment.where(post_id: params[:post_id])

    render json: comments
  end

  def show
    comment = Comment.find(params[:id])

    render json: comment
  end

  def create
    comment = Comment.new(comment_params.merge(user_id: current_user.id, post_id: params[:post_id]))

    if comment.save
      render json: comment, status: :created
    else
      render json: comment.errors, status: :unprocessable_entity
    end
  end

  def update
    comment = Comment.find(params[:id])

    if comment.update(comment_params)
      render json: comment
    else
      render json: comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    comment = Comment.find(params[:id])

    comment.destroy
  end

  private
    def comment_params
      params.require(:comment).permit(:body)
    end
end
