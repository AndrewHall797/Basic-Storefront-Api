Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  get 'products/purchase' => 'products#purchase'
  post 'carts/add' => 'carts#add_product'
  get 'carts/checkout' => 'carts#checkout'
  
  resources :products
  resources :carts
end
