class CreationsController < ApplicationController
	# skip_before_action :authenticate

	def index
		# byebug
		render json: Creation.where(account_id: auth[0]['account_id'])
	end


	def show
		render json: Creation.find(params[:id])
	end

  def create
		data = request.env['RAW_POST_DATA']
		json = JSON.parse(data)['addons']
    creation = Creation.new(composition: json)
		creation.account = current_account
		if creation.save
			render json: Creation.where(account_id: auth[0]['account_id'])
  	else
  		render json: "Error saving your creation", status: 401
  	end

  end

	def destroy
		creation = Creation.where(account_id: auth[0]['account_id'], id: params[:id])
		if (creation.delete)
			render json: Creation.where(account_id: auth[0]['account_id'])
		else
			render json: "Error deleting your creation", status: 401
		end
	end


  private

end
