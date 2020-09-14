class RatingsController < ApplicationController
  def create
    next_post_id = params[:rating][:next_post_id]
    redirect_path =
      if next_post_id.present?
        posts_rate_path next_post_id
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
