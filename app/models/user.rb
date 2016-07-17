class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable
  #       :recoverable, :rememberable, :trackable

  has_many :carts
  belongs_to :current_cart, class_name: 'Cart'

  def create_cart
    self.current_cart = self.carts.new
    self.save
  end

  def unset_current_cart
    self.current_cart_id = nil
    self.save
  end
end
