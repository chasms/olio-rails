class AccountsController < ApplicationController

	def index
    	@accounts = Account.all
    	render json: @accounts
  	end

  	private

  	def account_params
    	params.require(:account).permit(:username, :email, :password)
  	end
end
