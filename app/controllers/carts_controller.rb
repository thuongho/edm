class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user, only: [:index]
  before_action :initialize_cart
  before_action :not_user_cart, only: [:index]
  
  

  def index
    @cart = Cart.where(user_id: @user.id).recent.first
    @cart_items = LineItem.where(cart_id: @cart.id)
  end

  def add
    @listing = Listing.find(params[:id])

    if request.post?
      @item = @cart.add_listing(params[:id])
      flash[:notice] = "Added #{@listing.name} to cart."
      redirect_to controller: "listings", action: "show"
    else
      render
    end
  end

  def clear
    if request.post?
      @cart.line_items.destroy_all
      flash[:notice] = "Your cart is empty."
      redirect_to root_url
    else
      render
    end
  end

  private

    def find_user
      @user = User.find(params[:id])
    end

    def initialize_cart
      if session[:cart_id]
        @cart = Cart.find(session[:cart_id])
      else
        # @cart = Cart.create
        @cart = Cart.new
        # @cart.user_id ||= current_user.id
        @cart.user_id = current_user.id
        @cart.save
        session[:cart_id] = @cart.id
      end
    end

    def not_user_cart
      if current_user.id != @cart.user_id
        redirect_to root_url
      end
    end

end
