class CartController < ApplicationController
  
  before_action :authenticate_user!
  
  def add
    # get the Id of the product
    id = params[:id]
    # if the cart is already been created, use existing cart else create a blank cart
    if session[:cart] then
      cart = session[:cart]
    else
      session[:cart] = {}
      cart = session[:cart]
    end
    #If the product is already added it increments by 1 else product set to 1
    if cart[id] then
      cart[id] = cart[id] + 1
    else
      cart[id]= 1
    end
    redirect_to :action => :index
  end

  def clearCart
    #sets session variable to nil and bring back to index
    session[:cart] = nil
    redirect_to :action => :index
  end 
  
  def index
    @orders = Order.all
    @orderitems = Orderitem.where(order_id: Order.last)
    # passes a cart to display
    if session[:cart] then
      @cart = session[:cart]
    else
      @cart = {}
    end
  end
  
  def remove
    id = params[:id]
    cart = session[:cart]
    cart.delete id
    redirect_to :action => :index
  end
  
  def createOrder
    @howmuchnow = session[:payme]
    @howmuch = params[:price]
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
  
  def clearOrder
    
    #if there is no total or orderitems redirect
    
    @user = User.find(current_user.id)
    @orders = Order.where(user_id: current_user.id)
    
    @orderitems = Orderitem.where(order_id: Order.last)
    
    # Esto es como estaba antes
    # @orderitems = Orderitem.where(order_id: Order.last)
    
    #@order = @user.orders.build(:order_date => DateTime.now, :status => 'Pending')
  end
  
  

end
