class SessionsController < ApplicationController
  def new
    if current_user != nil
      flash[:message] = "You are already logged in."
      redirect_to profile_path if current_user.role == "user"
      redirect_to dashboard_path if current_user.role == "merchant"
      redirect_to root_path if current_user.role == "admin"
    end
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:message] = "Welcome, #{user.name}! You're now logged in!"
      redirect_to profile_path if user.role == "user"
      redirect_to dashboard_path if user.role == "merchant"
      redirect_to root_path if user.role == "admin"
    else
      flash[:message] = "Your credentials were entered incorrectly."
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:message] = "You're now logged off!"
    redirect_to root_path
  end
end
