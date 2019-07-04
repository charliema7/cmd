Rails.application.routes.draw do
  resources :user_types
  devise_for :users, :controllers => { :registrations => 'users/registrations',
                                        invitations: 'users/invitations' }
  resources :users
  resources :login_activities, only: [:index, :show]
  resources :invitations, only: [:index, :resend] do
    member do
      get :resend
    end
  end
  get 'home/index'
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
