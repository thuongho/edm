class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user, only: [:index]
  before_action :current_cart
  before_action :not_user_cart, only: [:index]
  
  

  def index
    @cart = Cart.where(user_id: @user.id).recent.first
    @cart_items = LineItem.where(cart_id: @cart.id)
  end

  def add
    @listing = Listing.find(params[:id])

    if request.post?
      @item = @current_cart.add_listing(params[:id])
      flash[:notice] = "Added #{@listing.name} to cart."
      redirect_to controller: "listings", action: "show"
    else
      render
    end
  end

  def clear
    if request.post?
      @current_cart.line_items.destroy_all
      flash[:notice] = "Your cart is empty."
      # @current_cart.save
      redirect_to root_url
    else
      render
    end
  end

  private

    def find_user
      @user = User.find(params[:id])
    end

    # def current_cart
    #   if session[:cart_id]
    #     @current_cart ||= Cart.find(session[:cart_id])
    #     session[:cart_id] = nil if @current_cart.purchased_at
    #   end
    #   if session[:cart_id].nil?
    #     @current_cart = Cart.create!(user_id: current_user.id)
    #     # @cart = Cart.new
    #     # @cart.user_id = current_user.id
    #     # @cart.save
    #     session[:cart_id] = @current_cart.id
    #   end
    #   @current_cart
    # end

    def not_user_cart
      if current_user.id != @current_cart.user_id
        redirect_to root_url
      end
    end

end
