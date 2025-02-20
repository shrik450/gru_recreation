# typed: strong
# This is an autogenerated file for Rails routes.
# Please run bundle exec rake rails_rbi:routes to regenerate.
class ActionController::Base
  include GeneratedUrlHelpers
end

module ActionView::Helpers
  include GeneratedUrlHelpers
end

class ActionMailer::Base
  include GeneratedUrlHelpers
end

module GeneratedUrlHelpers
  # Sigs for route /
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def root_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def root_url(*args, **kwargs); end

  # Sigs for route /login(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def login_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def login_url(*args, **kwargs); end

  # Sigs for route /sessions/new(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def sessions_new_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def sessions_new_url(*args, **kwargs); end

  # Sigs for route /posts/rate(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def posts_rate_index_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def posts_rate_index_url(*args, **kwargs); end

  # Sigs for route /posts/rate/:id(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def posts_rate_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def posts_rate_url(*args, **kwargs); end

  # Sigs for route /posts(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def posts_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def posts_url(*args, **kwargs); end

  # Sigs for route /posts/:id(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def posts_show_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def posts_show_url(*args, **kwargs); end

  # Sigs for route /posts/:id(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def posts_update_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def posts_update_url(*args, **kwargs); end

  # Sigs for route /rating(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rating_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rating_url(*args, **kwargs); end

  # Sigs for route /code(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def code_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def code_url(*args, **kwargs); end

  # Sigs for route /code/:id(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def codes_destroy_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def codes_destroy_url(*args, **kwargs); end
end
