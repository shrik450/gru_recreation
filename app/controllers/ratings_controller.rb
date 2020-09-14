class RatingsController < ApplicationController
  def create
    redirect_path =
      if params[:next_post_id].present?
        posts_rate_path(params[:next_post_id])
      else
        root_path
      end

    if Rating.create(rating_params)
      redirect_to redirect_path
    else
      alert.flash("Invalid")
    end
  end

  private

  def rating_params
    params.require(:rating).permit(:user_id, :post_id, :rating)
  end
end
