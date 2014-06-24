class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :initialize_cart
  before_action :find_user
  
  

  def index
    @cart = Cart.where(user_id: @user.id).recent.first
    @cart_items = LineItem.where(cart_id: @cart.id)
  end

  def add
    @listing = Listing.find(params[:id])

    if request.post?
      @item = @cart.add_listing(params[:id])
      # flash[:cart_notice] = "Added <em>#{@item.listing.name}"
      flash[:notice] = "Item added."
      redirect_to controller: "listings", action: "show"
    else
      render
    end
  end

  # def add
  # end

  private

    def find_user
      @user = User.find(params[:id])
      if current_user.id != @cart.user_id
        redirect_to root_url
      end
    end

    def initialize_cart
      if session[:cart_id]
        @cart = Cart.find(session[:cart_id])
      else
        @cart = Cart.create
        @cart.user_id = current_user
        session[:cart_id] = @cart.id
      end
    end

end
