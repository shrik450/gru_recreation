# typed: false
class ApplicationController < ActionController::Base
  extend T::Sig
  before_action :authenticate

  private

  sig {void}
  def authenticate
    if current_user.blank?
      session[:redirect_url] = request.original_url
      redirect_to login_url
    end
  end

  sig {returns(T.nilable(User))}
  def current_user
    user_id = session[:user_id]
    User.find_by(id: user_id)
  end

  sig {void}
  def render_forbidden
    render plain: "Forbidden", status: :unauthorized
  end
end
