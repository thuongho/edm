class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
<<<<<<< HEAD
  # include ListingsHelper

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
=======

  before_action :configure_permitted_parameters, if: :devise_controller?
>>>>>>> 11b131bbe530968891bc462422722812efa83dd3

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:account_update) << :name
  end
<<<<<<< HEAD

  private

    # def initialize_cart
    #   if session[:cart_id]
    #     @cart = Cart.find(session[:cart_id])
    #   else
    #     @cart = Cart.create
    #     @cart.user_id = current_user.id
    #     session[:cart_id] = @cart.id
    #   end
    # end
=======
>>>>>>> 11b131bbe530968891bc462422722812efa83dd3
end
