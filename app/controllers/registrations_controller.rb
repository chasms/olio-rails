class RegistrationsController < ApplicationController
	skip_before_action :authenticate

  def create
		byebug
  	account = Account.new(account_params)
  	if account.save
  		token = Auth.issue({account_id: account.id})
  		render json: {token: token}
  	else
  		render json: "Error creating account #{account.username}", status: 401
  	end
  end

  private

  def account_params
  	params.require(:registration).permit(:username, :email, :password, :passwordConfirmation)
  end

end
