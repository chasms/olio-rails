class RegistrationsController < ApplicationController
	skip_before_action :authenticate

	def create
		account = Account.new(account_params)
		# creation = Creation.find(3)
		# about_us = Creation.new(composition: creation.composition, title: creation.title)
		# account.creations << creation
		if account.save
			token = Auth.issue({account: account.id})
			render json: {token: token, account: account.username, creations: account.creations}
		else
			render :json => { :errors => account.errors.full_messages }, :status => 422
		end
	end

	private

	def account_params
		params.require(:registration).permit(:username, :email, :password, :password_confirmation)
	end

end
