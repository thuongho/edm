class CartController < ApplicationController
  before_action :initialize_cart

  def add
    @listing = Listing.find(params[:id])

    if request.post?
      @item = @cart.add(params[:id])
      flash[:cart_notice] = "Added <em>#{@item.listing.name}"
      redirect_to controller: "listings", action: "show"
    else
      render
    end
  end
end
