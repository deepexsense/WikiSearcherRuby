Rails.application.routes.draw do
  # resources :searches
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/' => 'searches#index'
  root 'searches#index'

end
