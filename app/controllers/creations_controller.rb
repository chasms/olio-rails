class CreationsController < ApplicationController

	ActionController::Parameters.permit_all_parameters

	def index
		render json: Creations.all
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
  		render json: "Error creating account #{creation}", status: 401
  	end

  end


  private

  def creation_params

  end
end
