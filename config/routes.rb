Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root 'rideshare#index'

resources :drivers
resources :trips
resources :passengers

resources :rideshare, only: [:index]
end
