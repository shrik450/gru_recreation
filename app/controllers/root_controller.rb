class RootController < ApplicationController
  def home
    @user = current_user
    @all_posts = Post.all
    @rated_posts = Post.rated_by(@user)
  end
end
