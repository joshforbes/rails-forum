class UsersController < ApplicationController
  skip_before_action :authenticate!, only: [:create]

  def create
    user = User.new(user_params)

    if user.save
      render json: user, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def update
    user = User.find(params[:id])

    if user.update(user_params)
      render json: user
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :name, :token, :password)
    end
end
