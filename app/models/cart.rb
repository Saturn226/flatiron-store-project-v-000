class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :line_items
  has_many :items, through: :line_items

  def add_item(item_id)
    cart_items = self.line_items.find_by(item_id: item_id.to_i)
    if cart_items
      cart_items.quantity += 1
      cart_items
    else
      # binding.pry
      self.line_items.new(item_id: item_id)
    end
  end

  def subtract_inventory
    self.line_items.each do |line_item|
      if line_item.item.inventory >= line_item.quantity
        line_item.item.inventory -= line_item.quantity
        line_item.item.save
      else
        "Not enough inventory on #{line_item.item.title}"
      end
    end
  end

  def total
    total_price = 0
    self.line_items.each{|line_item| total_price += line_item.quantity * line_item.item.price}
    total_price
  end

  def checkout
    self.subtract_inventory
    self.user.unset_current_cart
    self.update(status: 'submitted')
  end
end
