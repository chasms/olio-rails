class AddonsController < ApplicationController

	def index
		@addons = Addon.all
		render json: @addons
	end

	def show
		@addon = Addon.find(params[:id])
	end
end