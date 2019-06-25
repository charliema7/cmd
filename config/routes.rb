Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => 'users/registrations' }
  resources :users
  get 'home/index'
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
