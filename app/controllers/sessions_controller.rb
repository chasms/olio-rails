class SessionsController < ApplicationController
  def create
    account = Account.find_by(email: session_params[:email])
    if account.authenticate(session_params[:password])
      jwt = Auth.issue({account: account.id})
      render json: {jwt: jwt}
    else
    end
  end

  private
    def session_params
      params.require(:auth).permit(:email, :password)
    end
end
