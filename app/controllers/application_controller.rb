class ApplicationController < ActionController::API
  def require_jwt
    token = request.headers['HTTP_AUTHORIZATION']
    head :forbidden unless token
    return if valid_token(token)

    head :forbidden
  end

  private

  def valid_token(token)
    return false unless token

    token.gsub!('Bearer ', '')
    begin
      decoded_token = JWT.decode token, 'HS256'
      return true
    rescue JWT::DecodeError => e
      Rails.logger.warn 'Error decoding the JWT: ' + e.to_s
    end
    false
  end

  def render_json(status, json = {})
    render status:, json:
  end
end
