Rails.application.routes.draw do
  get 'home/index'
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :consultations
  devise_for :users, :controllers => { :registrations => 'users/registrations',
                                        invitations: 'users/invitations' }
  resources :users, :user_types
  resources :login_activities, only: [:index, :show]
  resources :invitations, only: [:index, :resend] do
    member do
      get :resend
    end
  end

  resources :mailbox do
    collection do
      get :inbox
      get :sent
      get :trash
    end
  end

  resources :conversations do
    resources :messages
    member do
      post :add_participant
      post :reply
      post :opt_in
      post :opt_out
      post :trash
      post :untrash
    end
  end

  mount ActionCable.server, at: '/cable'
end
