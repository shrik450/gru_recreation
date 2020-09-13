class SessionsController < ApplicationController
  skip_before_action :authenticate

  def new
    user = User.find_by(email: params[:email])
    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id
      if session[:redirect_url].present?
        redirect_url = session[:redirect_url]
        session[:redirect_url] = ""
      else
        redirect_url = root_url
      end
      redirect_to redirect_url
    else
      @error = "E-Mail or Password is invalid."
      render "new"
    end
  end
end
