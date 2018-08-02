Rails.application.routes.draw do
  get 'errors/not_found'
  get 'errors/internal_server_error'
  resources :categories
  get 'orderitems/index'
  get 'orderitems/show'
  get 'orderitems/new'
  get 'orderitems/edit'
  
  resources :orders do 
    resources:orderitems
  end
  
  resources :contacts, only: [:new, :create]

  devise_for :admins
  
  devise_for :users do
    resources :orders
  end
  
  get 'cart/index'
  resources :items
  
  # Stripe resources
  resources :charges
  
  root 'static_pages#home'
  
  get "/users" => 'user#show'

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
  
  get '/checkout/:price' => 'cart#clearOrder'
  
  # Devise routes
  root :to => 'site#home'
  
  # Orders routes
  get '/orders' => 'order#show'
  get '/paid/:id' => 'static_pages#paid'
  
  # Admin orders
  get '/adorders' => 'orders#adminorders'
  
  # Paypal route
  get '/thanks/:id' => 'static_pages#thanks'
  
  # Category routes
  get 'category/:title', to: 'static_pages#category'
  
  # Search routes
  post '/search' => 'items#search'
  
  # Profile route
  # get 'confirmations/edit' => 'confirmations#edit'
  get '/profile' => 'static_pages#profile'
  
  # Error routes
  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all
  
  # Translation
  scope '(:locale)' do
    resources :orders
    resources :line_items
    resources :carts
    root 'static_pages#home', as: 'index', via: :all
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
