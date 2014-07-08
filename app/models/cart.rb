class Cart < ActiveRecord::Base

  has_many :line_items
  has_many :listings, through: :line_items
  has_one :order

  scope :recent, lambda { order("created_at DESC")}

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

  # obsolete
  def total
    if line_items.length > 0
      line_items.inject(0) {|sum, n| n.price * n.quantity + sum}
    end
  end

  def total_price
    # convert to array so it doesn't try to do sum on database directly
    line_items.to_a.sum(&:full_price)
  end

  # def in_cents(cost)
  #   cost * 100
  # end

  def paypal_url(return_url, notify_url)
    values = {
      business: 'thuong.t.ho-developer@gmail.com',
      cmd: '_cart',
      upload: 1,
      :return => return_url,
      invoice: id,
      notify_url: notify_url
    }
    line_items.each_with_index do |item, index|
      values.merge!({
        "amount_#{index+1}" => item.price.to_i * 100,
        "item_name_#{index+1}" => item.listing.name,
        "item_number_#{index+1}" => item.id,
        "quantity_#{index+1}" => item.quantity.to_i
      })
  end
  "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
  end

end
