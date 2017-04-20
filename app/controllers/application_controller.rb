class ApplicationController < ActionController::Base
   before_action :authenticate

  def logged_in?
    !!current_account
  end

  def current_account
    if auth_present?
      account = User.find(auth["account"])
      if account
        @current_account ||= account
      end
    end
  end

  def authenticate
    unless logged_in?
      render json: {error: "unauthorized"}, status: 401
    end

  end

  private

  def token
    request.env["HTTP_AUTHORIZATION"].scan(/Bearer
    (.*)$/).flatten.last
  end

  def auth
    Auth.decode(token)
  end

  def auth_present?
    !!request.env.fetch("HTTP_AUTHORIZATION",
    "").scan(/Bearer/).flatten.first
  end

end
