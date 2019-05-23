class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
end

  helper_method :cart

  def cart
    @cart ||= Cart.new(session[:cart])
  end
