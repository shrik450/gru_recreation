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
  end

  def rate
  end

  def rate_index
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end
end
