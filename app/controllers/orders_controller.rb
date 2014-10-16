class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # before_action :find_listing, only: [:new, :create]
  before_action :current_cart
  before_action :c_items, only: [:express]



  def express

    response = EXPRESS_GATEWAY.setup_purchase(current_cart.build_order.price_in_cents, 
      ip: request.remote_ip,
      return_url: new_order_url,
      cancel_return_url: root_url,
      currency: "USD",
      allow_guest_checkout: true,
      # items: [{name: "DjM", description: "DontjudgeMe Clothing purchase", amount: current_cart.build_order.price_in_cents}]
      items: @c_item
      )
    redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
  end 

  def sales
    # @orders = Order.all.where(seller: current_user).recent
    @orders = LineItem.listing.user.all.where()
  end

  def purchases
    @orders = Order.all.where(buyer: current_user).recent
  end

  # GET /orders/new
  def new
    # @order = Order.new
    @order = Order.new(:express_token => params[:token])
  end

  # POST /orders
  # POST /orders.json
  def create
    # @order = Order.new(order_params)
    # @order = @current_cart.build_order(params[:order])

    # Using activemerchant
    @order = @current_cart.build_order(order_params)
    @order.ip = request.remote_ip
    # @seller = @listing.user

    # @order.listing_id = @listing.id
    @order.buyer_id = current_user.id
    # @order.seller_id = @seller.id
    # @order.cart_id = current_user.cart.id
    # @order = Order.make_order(params[:token], current_user, current_cart, request.remote_ip)

    # respond_to do |format|
      if @order.save
        if @order.purchase
          # render action: "success"
          redirect_to root_url, notice: 'Order was successful.'
        else
          # render action: "fail"
          redirect_to root_url, notice: 'Order was not successful.'
        end
        # format.html { redirect_to root_url, notice: 'Order was successfully created.' }
        # format.json { render :show, status: :created, location: @order }
      else
        # format.html { render :new }
        # format.json { render json: @order.errors, status: :unprocessable_entity }
        render :new
      end
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      # params.require(:order).permit(:address, :city, :state)
      params.require(:order).permit(:order, :express_token)
    end

    def find_listing
      @listing = Listing.find(params[:listing_id]) # find listing id in url
    end

    def cart_total_in_cents
      @current_cart.total.to_i * 100
    end

    def c_items
      @c_item = []
      @current_cart.line_items.each_with_index do |item, index|
        @c_item.push(
          {
            amount: (item.price * 100).round,
            name: item.listing.name,
            number: item.listing.id,
            quantity: item.quantity
          }
        )
      end
      return @c_item
    end
end
