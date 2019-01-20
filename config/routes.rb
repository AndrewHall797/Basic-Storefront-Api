Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  get 'products/available' => 'products#inventory_avalible'
  get 'products/purchase' => 'products#purchase'
  resources :products
end
