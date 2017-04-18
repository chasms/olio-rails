class CategoriesController < ApplicationController

	def index
		render json: @categories = Category.all
	end

	# def create
 # 	 	@category = Category.new(name: params[:name])
  # 	if @category.save
  #  	 	redirect_to @category
  # 	else
  # 		render json: @category.errors.full_messages #status
  # 	end
	# end

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
