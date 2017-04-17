class RegistrationsController < ApplicationController
	
	def create
   	 	@account=Account.new(email: params[:email], password: params[:password])
    	if @account.save
     	 	render json: @account
    	else
      		render json: @account.errors.full_messages #status
    	end
  	end
end

