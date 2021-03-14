class CategoriesController < ApplicationController

  before_action :set_category, only: [:show, :update]

  def index
    @categories = Category.all

    json_response(@categories)
  end

  def create
    @category = Category.create!(category_params)

    json_response(@category)
  end

  def show
    json_response(@category)
  end

  def update
    @category.update(category_params)

    head :no_content
  end

  private

  def category_params
    params.permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
