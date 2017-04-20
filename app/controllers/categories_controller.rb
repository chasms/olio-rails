class CategoriesController < ApplicationController
	skip_before_action :authenticate
	def index
		render json: Category.all, each_serializer: CategorySerializer
	end

	def addons
		render json: Category.all, each_serializer: CategoryWithAddonsSerializer
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
