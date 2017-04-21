class SessionsController < ApplicationController

  def create
    byebug
    account = Account.find_by(username: session_params(:username).downcase)
    if account.try(:authenticate, session_params(:password))
      token = Auth.issue({account_id: account.id})
      render json: {token: token}
    else
      render json: "Your username or password was incorrect", status: 401
    end
  end

  private

    def session_params(*args)
      params.permit(*args)
    end

end
