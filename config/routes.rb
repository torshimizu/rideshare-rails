Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root 'rideshare#index'

get 'drivers/by_name', to: 'drivers#by_name', as: 'by_name'
resources :drivers do
  resources :trips, only: [:index]
end

get 'passengers/by_name', to: 'passengers#by_name', as: 'passenger_by_name'
resources :passengers do
  resources :trips, only: [:index, :new]
end

resources :trips
resources :rideshare, only: [:index]
end
