class ChargesController < ApplicationController
  
  before_action :authenticate_user!
    
    def new
      redirect_to :root
       @order = Order.last
    @order.update_attribute(:status , "Paid by Stripe: #{current_user.email}")
    end
    
    def index
      #if params[:set_locale]
        #redirect_to store_url(locale: params[:set_locale])
      #else
        @order = Order.last
        @order.update_attribute(:status , "Paid by Stripe: #{current_user.email}")
      #end
    end

    def create
      # Amount in cents
      @amount = 500
      # @orderno = Order.find(params[:id])
      customer = Stripe::Customer.create(
        :email => params[:stripeEmail],
        :source  => params[:stripeToken]
      )
    
      charge = Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => @amount,
        :description => 'Rails Stripe customer',
        :currency    => 'eur'
      )
        @orderNum = (params[:orderid])
        redirect_to "/paid/#{@orderNum}"
        rescue Stripe::CardError => e
        flash[:error] = e.message
        redirect_to new_charge_path
         
    end
    #@user = User.find(current_user.id)
    #@order.update_attribute(:status , "Paid by User: #{current_user.email}")
    
   # redirect_to :controller => 'items', :action => 'index'
end

# This controller does two things
# 1. Shows a credit card form (using Checkout).
# 2. Creates the actual charges by calling our API.


