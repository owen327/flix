class SessionsController < ApplicationController
  def new

  end

  def create
#    user = User.find_by(email: params[:email])
    if user = User.authenticate(params[:email], params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Welcome back, #{user.name}!"
      redirect_to(session[:intended_url] || user)
    else
      flash.now[:alert] = "Invalid email/password combination!"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You're now signed out!"
    redirect_to root_url
  end
end
