class SessionsController < ApplicationController

  skip_before_action :authenticate

  def create

    account = Account.find_by(username: session_params[:username])
    if account.authenticate(session_params[:password])
      jwt = Auth.issue({account: account.id})
      render json: {token: jwt, creations: account.creations}, status: 200
    else
      render :json => { :errors => account.errors.full_messages }, :status => 422
    end
  end

  private


    def session_params
      params.permit(:username, :password)
    end
end
