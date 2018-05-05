Rails.application.routes.draw do
  devise_for :users,
    path: 'auth',
    controllers: {
      registrations: 'users/registrations',
      passwords: 'users/passwords',
      sessions: 'users/sessions',
      confirmations: 'users/confirmations'
    },
    path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      password: 'secret',
      confirmation: 'verification',
      unlock: 'unblock',
      registration: 'register',
      sign_up: 'cmon_let_me_in' }

  resources :bulletins, only: [:create, :destroy, :edit, :update]
  resources :tags, only: [:show]
  resources :topics, shallow: true do
    resources :bumps, only: [:create]
    resources :objections
    resources :replies
  end
  resources :users, only: [:destroy, :edit, :index, :show]

  get 'search', to: 'search#index', as: :search

  root to: "home#index"
end
