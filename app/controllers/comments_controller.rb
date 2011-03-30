class CommentsController < ApplicationController
  before_filter :authenticate_user!
  
  def create
    @day = Day.find(params[:post_id])
    @comment = @day.comments.create(params[:comment])
    redirect_to post_path(@day)
  end
end
