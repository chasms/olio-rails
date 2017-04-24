class RegistrationsController < ApplicationController
	skip_before_action :authenticate

  def create
  	account = Account.new(account_params)
  	if account.save
  		token = Auth.issue({account: account.id})
  		render json: {token: token}
  	else
  		render json: "Error creating account #{account.username}", status: 401
  	end
  end

  private

  def account_params
  	params.require(:registration).permit(:username, :email, :password, :password_confirmation)
  end

end
