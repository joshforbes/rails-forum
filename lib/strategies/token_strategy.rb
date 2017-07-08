class TokenStrategy < ::Warden::Strategies::Base
  def valid?
    token
  end

  def authenticate!
    user = User.find_by_token(token)
    user.nil? ? fail!('strategies.token.failed') : success!(user)
  end

  private
  def token
    request.env['HTTP_AUTHORIZATION']
  end
end