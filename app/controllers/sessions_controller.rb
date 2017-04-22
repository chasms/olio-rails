class SessionsController < ApplicationController

  skip_before_action :authenticate

  def create
    byebug
    account = Account.find_by(email: session_params[:email])
    if account.authenticate(session_params[:password])
      jwt = Auth.issue({account: account.id})
      render json: {jwt: jwt}
    else
      render json: "Your username or password was incorrect", status: 401
    end
  end

  private

    def session_params()
      params.require(:sessions).permit(:username, :password)
    end

end
