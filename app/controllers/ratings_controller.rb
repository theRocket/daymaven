class RatingsController < ApplicationController
    before_filter :authenticate_user!

    def create
        @day = Day.find_by_id(params[:day_id])
        if current_user.id == @day.user_id
            redirect_to day_path(@day), :alert => "You cannot rate your own day"
        else
            @rating = Rating.new(params[:rating])
            @rating.day_id = @day.id
            @rating.user_id = current_user.id
            if @rating.save
                respond_to do |format|
                    format.html { redirect_to day_path(@day), :notice => "Your rating has been saved" }
                    format.js
                end
            end
        end
    end

    def update
        @day = Day.find_by_id(params[:day_id])
        if current_user.id == @day.user_id
            redirect_to day_path(@day), :alert => "You cannot rate for your own day"
        else
            @rating = current_user.ratings.find_by_day_id(@day.id)
            if @rating.update_attributes(params[:rating])
                respond_to do |format|
                    format.html { redirect_to day_path(@day), :notice => "Your rating has been updated" }
                    format.js
                end
            end
        end
    end
end
