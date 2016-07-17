module ApplicationHelper

  def number_to_currency(price)
    "$#{price.to_f/100}"
  end

end
