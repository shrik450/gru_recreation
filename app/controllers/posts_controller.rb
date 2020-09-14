# typed: ignore
class PostsController < ApplicationController
  before_action :set_post, except: %i[index rate_index]

  def index
    if current_user.admin?
      @q = Post.ransack(params[:q])
      @posts = @q.result.page(params[:page])
      render "index"
    else
      render_forbidden
    end
  end

  def show
    unless current_user.admin?
      render_forbidden
    end
  end

  def rate
    @user = current_user
    @next_post = Post.random_top_100_post_unrated_by(current_user)
    @rating = Rating.new
    render "rate"
  end

  def rate_index
    unrated_post = Post.random_top_100_post_unrated_by(current_user)
    if unrated_post.present?
      redirect_to posts_rate_path(unrated_post.id)
    else
      render plain: "No posts left to rate."
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end
end
