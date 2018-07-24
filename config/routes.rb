Rails.application.routes.draw do
  get 'orderitems/index'
  get 'orderitems/show'
  get 'orderitems/new'
  get 'orderitems/edit'
  
  resources :orders do 
    resources:orderitems
  end

  devise_for :admins
  
  devise_for :users do
    resources :orders
  end
  
  get 'cart/index'
  resources :items
  
  # Stripe resources
  resources :charges
  
  root 'static_pages#home'

  # Static pages routes
  get '/home' => 'static_pages#home'
  get '/contact' => 'static_pages#contact'
  get '/about' => 'static_pages#about'
  get '/items' => 'items#index'
  
  # Users routes
  get '/login' => 'user#login'
  get '/logout' => 'user#logout'
  get '/admin/login' => 'admin#login'
  get '/admin/logout' => 'admin#logout'
  
  # Cart routes
  get '/cart/clear' => 'cart#clearCart'
  get '/cart' => 'cart#index'
  get '/cart/:id' => 'cart#add'
  get '/cart/remove/:id' => 'cart#remove'
  
  get '/checkout' => 'cart#createOrder'
  
  # Devise routes
  root :to => 'site#home'
  
  # Orders routes
  get '/orders' => 'order#show'
  get '/paid' => 'static_pages#paid'
  
  # Paypal route
  get '/thanks/:id' => 'static_pages#thanks'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
