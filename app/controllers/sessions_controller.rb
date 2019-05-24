class SessionsController < ApplicationController
  def new

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
      flash[:message] = "Invalid Password" if user
      flash[:message] = "Invalid Email" if !user
    end
  end

  def destroy
    redirect_to root_path
  end
end
