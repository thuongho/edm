class Cart < ActiveRecord::Base

  has_many :line_items
  has_many :listings, through: :line_items

  scope :recent, lambda { order("created_at DESC")}

  # attr_reader :items
  # attr_reader :total_price

  # :items
  # :total_price

  # def initialize
  #   @items = []
  #   @total_price = 0.0
  # end

  # def add_listing(listing)
  #   @items << Item.new_based_on(listing)
  #   @total_price += listing.price
  # end

  # def total
  #   line_items.inject(0) {|sum, n| n.price * n.quantity + sum}
  # end

  def add_listing(listing_id)
    items = line_items.where(listing_id: listing_id)
    listing = Listing.find(listing_id)

    if items.size < 1
      cart_item = line_items.create(listing_id: listing_id,
                                    quantity: 1,
                                    price: listing.price)
    else
      cart_item = items.first
      cart_item.update_attribute(:quantity, cart_item.quantity + 1)
    end
  end

end
