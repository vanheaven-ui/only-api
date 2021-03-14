class PublicationsController < ApplicationController

  before_action :set_user
  before_action :set_category, only: [:create]
  before_action :set_publication, only: [:show, :update, :destroy]

  def index
    json_response(@user.publications)
  end

  def create
    puts params
    params[:category_id] = @category.id
    @user.publications.create!(publication_params)
    json_response(@user, :created)
  end

  def show
    json_response(@publication)
  end

  def update
    @publication.update(publication_params)

    head :no_content
  end

  def destroy
    @publication.destroy

    head :no_content
  end

  private

  def set_category
    @category = Category.find(params[:category_id])
  end

  def publication_params
    params.permit(:title, :author, :category_id)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_publication
    @publication = @user.publications.find_by!(id: params[:id]) if @user
  end
end
