Spree::Core::Engine.routes.draw do
  get 'account/orders' => 'users#orders'
  match 'account/addresses' => 'users#addresses', via: [:get,:put]
end
