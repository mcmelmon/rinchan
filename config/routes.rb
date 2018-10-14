Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
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

  resources :bulletins, shallow: true
  resources :tags, only: [:show]
  resources :topics, shallow: true do
    collection do
      get :preview_link
    end
    member do
      get :remove_link
    end
    resources :bumps, only: [:create, :destroy]
    resources :objections
    resources :replies do
      collection do
        get :preview_link
      end
      member do
        get :remove_link
      end
      resources :demurrals, only: [:create, :destroy]
      resources :thanks, only: [:create, :destroy]
    end
  end
  resources :users, only: [:destroy, :edit, :index, :show], shallow: true do
    resources :bumps, only: [:index]
    resources :demurrals, only: [:index]
    resources :objections, only: [:index]
    resources :thanks, only: [:index]
  end

  get 'search', to: 'search#index', as: :search

  root to: "home#index"
end
