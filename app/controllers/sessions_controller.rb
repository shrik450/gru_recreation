class SessionsController < ApplicationController
  skip_before_action :authenticate

  def new
    user = User.find_by(email: params[:email])
    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url
    else
      @error = "E-Mail or Password is invalid."
      render "new"
    end
  end
end
