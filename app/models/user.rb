class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true

  has_many :listings, dependent: :destroy
  has_many :sales, class_name: "Order", foreign_key: "seller_id"
<<<<<<< HEAD
  has_many :purchases, class_name: "Order", foreign_key: "buyer_id"  
  has_one :cart, dependent: :destroy     
=======
  has_many :purchases, class_name: "Order", foreign_key: "buyer_id"       
>>>>>>> 11b131bbe530968891bc462422722812efa83dd3
end
