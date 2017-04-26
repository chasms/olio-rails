class AccountsController < ApplicationController

		def index
    	render json: current_account
  	end


  	private

  	def account_params
    	params.require(:account).permit(:username, :email, :password)
  	end

end
