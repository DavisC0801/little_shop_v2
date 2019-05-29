class Admin::UsersController < Admin::BaseController
  def index
    @users = User.find_users
  end

  def show
    @user = User.find(params[:id])
  end
end
