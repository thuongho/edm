class Cart

  # attr_reader :items
  # attr_reader :total_price

  :items
  :total_price

  def initialize
    @items = []
    @total_price = 0.0
  end

  def add_listing(listing)
    @items << Item.new_based_on(listing)
    @total_price += listing.price
  end

end
