class UsersController < ApplicationController
  def new

  end

  def show
    @user = current_user
    render file: "/public/404", status: 404 unless @user
  end

  def edit
    @user = current_user
  end

  def update
    user = User.find(current_user.id)
    user.update(user_params)
    redirect_to profile_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :address, :city, :state, :zip)
  end
end
