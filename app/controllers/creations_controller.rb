class CreationsController < ApplicationController

	ActionController::Parameters.permit_all_parameters

	def index
		render json: Creations.find_by(auth)
	end


	def show
	end

  def create
		data = request.env['RAW_POST_DATA']
		json = JSON.parse(data)['addons']
    creation = Creation.new(composition: json)
		creation.account = current_account
		if creation.save
			render json: creation
  	else
  		render json: "Error saving your creation", status: 401
  	end

  end


  private

end
