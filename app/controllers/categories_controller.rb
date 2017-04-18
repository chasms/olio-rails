class CategoriesController < ApplicationController

	def index
		render json: @categories = Category.all
	end

	def create
   	 	@category=Category.new(name: params[:name])
    	if @category.save
     	 	render json: @category
    	else
      		render json: @category.errors.full_messages #status
    	end
  	end
end
