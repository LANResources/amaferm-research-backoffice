Rails.application.routes.draw do
  get 'paper_searches/new'

  get 'paper_searches/create'

  resources :users, except: :show do
    member do
      post 'invite', to: 'invites#create', as: :invite
      get 'register/:invite_token', to: 'invites#edit', as: :rsvp
      match 'register', to: 'invites#update', via: [:patch, :put], as: :register
    end
  end

  resources :papers do
    get 'download', on: :member, as: :download
    collection do
      get 'search', to: 'paper_searches#search', as: :search
    end
  end

  resources :sessions, only: [:new, :create, :destroy]
  resource :password_reset, only: [:new, :create, :edit, :update]

  get 'login', to: 'sessions#new', as: :login
  delete 'logout', to: 'sessions#destroy', as: :logout

  root to: 'papers#index'
end
