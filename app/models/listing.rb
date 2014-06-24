class Listing < ActiveRecord::Base

  belongs_to :user
  has_many :orders, dependent: :destroy
  has_many :line_items
  has_many :carts, through: :line_items

  scope :recent, lambda { order("created_at DESC") }

  if Rails.env.development?
    has_attached_file :image, :styles => { :medium => "200x>", :thumb => "100x100>" }, 
                    :default_url => "/images/no_pic.jpg"
  else
    has_attached_file :image, :styles => { :medium => "200x>", :thumb => "100x100>" },
                      :storage => :dropbox,
                      :dropbox_credentials => Rails.root.join("config/dropbox.yml"),
                      :path => ":style/:id_:filename" 
  end

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates :name, :description, :price, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :image, presence: true

  
end
