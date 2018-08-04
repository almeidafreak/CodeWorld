class KeyController < ApplicationController
   def finishOrder
    @orderID = params[:oi]
    @user = User.find(current_user.id)
    @orderitems = Orderitem.where(order_id: Order.last)
    @linetotal = params[:price]
  end 
end