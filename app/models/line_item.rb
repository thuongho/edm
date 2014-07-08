class LineItem < ActiveRecord::Base
  belongs_to :listing
  belongs_to :cart
  # belongs_to :order

  # def self.new_based_on(listing)
  #   line_item = self.new
  #   line_item.listing = listing
  #   line_item.quantity = 1
  #   line_item.price = listing.price
  #   return line_item
  # end

  def full_price
    price * quantity
  end
end
