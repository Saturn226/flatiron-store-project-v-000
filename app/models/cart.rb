class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :line_items
  has_many :items, through: :line_items

  def total
    line_items.collect do |line_item|
      line_item.quantity * line_item.item.price
    end.inject { |sum, items_cost| sum + items_cost }
  end

  def add_item(item_id)
    line_item = self.line_items.find_by(item_id: item_id)
    if line_item
      line_item.quantity += 1
    else
      line_item=self.line_items.build(item_id: item_id)
    end
    line_item
  end

  def checkout
    line_items.each do |line_item|
      line_item.item.inventory -= line_item.quantity
      line_item.item.save
    end
    self.status = "submitted"
    self.save
  end

end