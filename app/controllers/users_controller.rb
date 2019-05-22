class UsersController < ApplicationController
  def new
    @user = User.new
  end

<<<<<<< Updated upstream
  def show
    @user = User.find_by_id(params[:format])
    render file: "/public/404", status: 404 unless @user
  end
=======
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

 def show
   
 end

 private

   def user_params
     params.require(:user).permit(:name, :address, :city, :state, :zip, :email, :password)
   end

>>>>>>> Stashed changes
end
