class CommentsController < ApplicationController
  before_filter :authenticate_user!
  
  def create
    @day = Day.find(params[:post_id])
    @comment = @day.comments.create(params[:comment])
	@comment.user = current_user
	@comment.save
    redirect_to day_path(@day)
  end
end
