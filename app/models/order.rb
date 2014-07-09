class Order < ActiveRecord::Base

  belongs_to :listing
  belongs_to :buyer, class_name: "User"
  belongs_to :seller, class_name: "User"
  has_many :line_items
  belongs_to :cart
  has_many :transactions, class_name: "OrderTransaction"

  scope :recent, lambda { order("created_at DESC") }

  # validates :address, :city, :state, presence: true

  # def self.make_order(token, user, cart, ip_address)
  #   order = self.new
  #   order.express_token = token
  #   order.ip = ip_address
  #   order.buyer_id = user.id
  #   order.cart_id = cart.id
  #   order.save!
  #   order.purchase
  #   return order
  # end

  def purchase
    response = EXPRESS_GATEWAY.purchase(price_in_cents, express_purchase_options)
    transactions.create!(action: "purchase", amount: price_in_cents, response: response)
    cart.update_attribute(:purchased_at, Time.now) if response.success?
    response.success?
  end

  def price_in_cents
    (cart.total_price * 100).round
  end

  def express_token=(token)
    self[:express_token] = token
    if new_record? && !token.blank?
      # you can dump details var if you need more info from buyer
      details = EXPRESS_GATEWAY.details_for(token)
      self.express_payer_id = details.payer_id
    end
  end


  private

    def express_purchase_options
      {
        ip: ip,
        token: express_token,
        payer_id: express_payer_id
      }
    end
end
