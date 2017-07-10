class ApplicationController < ActionController::API
  include WardenHelper
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    render status: :forbidden
  end
end
