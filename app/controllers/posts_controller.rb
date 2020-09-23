# typed: ignore
class PostsController < ApplicationController
  before_action :set_post, except: %i[index rate_index]
  before_action :render_forbidden_if_not_admin, only: %i[show index update]

  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).page(params[:page])
    render "index"
  end

  def show
    comments = @post.comments
    @q = comments.ransack(params:[:q])
    @q.sorts = ["score desc"] if @q.sorts.empty?
    @comments = @q.result(distinct: true).preload(comments: {comments: :comments})
    @user = current_user
  end

  def update
    @post.update(post_params)
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

  def post_params
    params.require(:post).permit(:image_not_present)
  end
end
