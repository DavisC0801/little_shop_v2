class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = current_user
    render file: "/public/404", status: 404 unless @user
  end

  def create
   user = User.new(user_params)
   if user.save
     session[:user_id] = user.id
     flash[:message] = "Welcome, #{user.name}! You're now registered and logged in!"
     
     redirect_to profile_path
   else
     user_params_no_email = user_params.except(:email)
     flash[:message] = user.errors.full_messages.first
     @user = User.new(user_params_no_email)
     render :new
   end
 end

  def edit
    @user = current_user
  end

  def update
    user = User.find(current_user.id)
    current_user.update(user_params)
    flash[:message] = "Your profile has been updated."
    redirect_to profile_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :address, :city, :state, :zip, :email, :password, :password_confirmation)
  end
end
