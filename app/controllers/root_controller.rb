# typed: true
class RootController < ApplicationController
  def home
    @user = current_user
    @all_posts = Post.top_100_for_any_month
    @rated_posts = @all_posts.rated_by(@user)
  end
end
