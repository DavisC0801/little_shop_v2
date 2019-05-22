class UsersController < ApplicationController
  def new

  end

  def show
    @user = User.find_by_id(params[:format])
    render file: "/public/404", status: 404 unless @user
  end
end
