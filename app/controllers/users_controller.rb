class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = current_user
    render file: "/public/404", status: 404 unless @user
  end

  def create
   @user = User.new(user_params)
   if @user.save
     flash[:message] = "Welcome, #{@user.name}!"
     redirect_to profile_path
   else
     flash[:message] = @user.errors.full_messages.first
     redirect_back(fallback_location: register_path)
   end
 end

  def edit
    @user = current_user
  end

  def update
    if current_user.update(user_params)
      flash[:message] = "Your profile has been updated."
      redirect_to profile_path
    else
      flash[:message] = current_user.errors.full_messages.first
      redirect_back(fallback_location: profile_edit_path)
    end
  end

  private

  def user_params
    if params[:user][:password] == "" || params[:user][:password] == nil
      params.require(:user).permit(:name, :address, :city, :state, :zip, :email)
    elsif User.find_by(email: params[:user][:email]) == params[:user][:email]
      flash[:message] = "Email has already been taken."
      redirect_back(fallback_location: profile_edit_path)
    else
      params.require(:user).permit(:name, :address, :city, :state, :zip, :email, :password, :password_confirmation)
    end
  end
end
