class Order < ActiveRecord::Base

  belongs_to :listing
  belongs_to :buyer, class_name: "User"
  belongs_to :seller, class_name: "User"
<<<<<<< HEAD
  has_many :line_items
=======
>>>>>>> 11b131bbe530968891bc462422722812efa83dd3

  scope :recent, lambda { order("created_at DESC") }

  validates :address, :city, :state, presence: true
end
