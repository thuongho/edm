class Order < ActiveRecord::Base

  belongs_to :listing
  belongs_to :buyer, class_name: "User"
  belongs_to :seller, class_name: "User"

  scope :recent, lambda { order("created_at DESC") }

  validates :address, :city, :state, presence: true
end
