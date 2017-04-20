class CategoriesController < ApplicationController
	skip_before_action :authenticate
	def index
		render json: @categories = Category.all
	end


	def show
		@category = Category.where(name: params[:name]).first
		if @category
			@addons = Addon.where(category_id: @category.id)
			render json: @addons
		else
			render json: @category
		end
	end

end
