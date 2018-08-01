class StaticPagesController < ApplicationController

  def home
    if params[:set_locale]
      redirect_to index_url(locale: params[:set_locale])
    else
      @categories = Category.all
      @items = Item.all
    end
  end

  def contact
  end

  def about
  end
  
  def profile
    @orders = Order.where(user_id: current_user.id)
    @users = User.where(email: current_user.email)
  end
  
  def createOrder
    # Step 1: Get the current user
   @user = User.find(current_user.id)
  
   # Step 2: Create a new order and associate it with the current user
   @order = @user.orders.build(:order_date => DateTime.now, :status => 'Pending')
   @order.save
  
   # Step 3: For each item in the cart, create a new item on the order!!
   @cart = session[:cart] || {} # Get the content of the Cart
   @cart.each do | id, quantity |
     item = Item.find_by_id(id)
     @orderitem = @order.orderitems.build(:item_id => item.id, :title => item.title, :description => item.description, :quantity => quantity, :price=> item.price)
     @orderitem.save
   end
   
   @orders = Order.all
   @orderitems = Orderitem.where(order_id: Order.last)
   session[:cart] = nil
  end
  
  def paid
    # redirect_to "/cart/clear"
    flash[:notice] = 'Transaction Complete'
    @order = Order.find(params[:id])
    @order.update_attribute(:status , "Paid with Stripe: #{current_user.email}")
  
    #"Paid by User:#{current_user.id} #{current_user.name} #{current_user.surname}")
  end

  def thanks
     @order = Order.find(params[:id])
     @order.update_attribute(:status, "Paid with PayPal")
  end
  
  def category
    catName = params[:title]
    @items = Item.where("category like ? ", catName)
  end
  
  def contacto
  end

end
