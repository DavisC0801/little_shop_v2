class SessionsController < ApplicationController
  def destroy
    redirect_to root_path
  end
end
