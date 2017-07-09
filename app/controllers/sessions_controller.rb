class SessionsController < ApplicationController
  skip_before_action :authenticate!, only: [:create]

  def create
    user = User.find_by_email(session_params[:email])

    if user && user.authenticate(session_params[:password])
      render json: { user: UserSerializer.new(user).attributes, token: user.token }, status: :ok
    else
      render json: '', status: :unauthorized
    end
  end

  def destroy
    current_user.regenerate_token

    head :no_content
  end

  private
  def session_params
    params.require(:user).permit(:email, :password)
  end
end
