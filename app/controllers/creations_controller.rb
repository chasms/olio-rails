class CreationsController < ApplicationController
	# skip_before_action :authenticate

	def index

		render json: current_account.creations
	end


	def show
		render json: Creation.find(params[:id])
	end

  def create
		data = request.env['RAW_POST_DATA']
		title = JSON.parse(data)['title']
		json = JSON.parse(data)['addons']
    creation = Creation.new(composition: json, title: title)
		creation.account = current_account
		if creation.save
			render json: current_account.creations
  	else
  		render :json => { :errors => creation.errors.full_messages }, :status => 422
  	end

  end

	def update
		data = request.env['RAW_POST_DATA']
		json = JSON.parse(data)['addons']
		title = JSON.parse(data)['title']
		creation = Creation.where(account: current_account, id: params[:id])[0]
		creation.composition = json
		creation.title = title
		if creation.save
			render json: current_account.creations
  	else
  		render :json => { :errors => 'Error updating your creation' }, :status => 422
  	end
	end

	def destroy

		creation = Creation.where(account: current_account, id: params[:id])[0]
		if creation.delete
			render json: current_account.creations
		else
			render json: "Error deleting your creation", status: 401
		end
	end


  private

end
