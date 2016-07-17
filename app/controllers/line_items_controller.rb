class LineItemsController < ApplicationController

  def create
    current_user.create_cart unless current_cart.present?
    line_item = current_cart.add_item(params[:item_id])
    if line_item.save
      redirect_to cart_path(current_cart), flash: {notice: 'Successfully added item.'}
    else
      redirect_to cart_path(current_user), flash: {notice: 'Unable to add the item.'}
    end
  end

end
