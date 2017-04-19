class CategoriesController < ApplicationController

	def index
		render json: @categories = Category.order('id DESC')
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
