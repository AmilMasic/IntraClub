Rails.application.routes.draw do
  resources :games
  resources :teams
  resources :players
  resources :sports
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
