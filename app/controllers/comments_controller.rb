class CommentsController < ApplicationController

  before_action :set_user
  before_action :set_comment, only: [:show, :update, :destroy]
  
  def index
    json_response(@user.comments)
  end

  def create
    puts params
    @user.comments.create!(comment_params)
    json_response(@user, :created)
  end

  def show
    json_response(@comment)
  end

  def update
    puts params
    @comment.update(comment_params)

    head :no_content
  end

  def destroy
    @comment.destroy

    head :no_content
  end

  private

  def comment_params
    params.permit(:body, :publication_id)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_comment
    @comment = @user.comments.find_by!(id: params[:id]) if @user
  end
end
