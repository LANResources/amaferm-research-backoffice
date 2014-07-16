Rails.application.routes.draw do
  get 'about', to: 'pages#about', as: :about
  get 'welcome', to: 'pages#welcome', as: :welcome

  resource :feedback, only: [:new, :create]

  resources :users, except: :show do
    member do
      post 'invite', to: 'invites#create', as: :invite
      get 'register/:invite_token', to: 'invites#edit', as: :rsvp
      match 'register', to: 'invites#update', via: [:patch, :put], as: :register
    end
  end

  resources :papers, except: :index do
    root to: 'trials#index'
    get 'download', on: :member, as: :download
    collection do
      get 'search', to: 'paper_searches#search', as: :search
    end
    resources :trials
  end

  resources :trials, only: :index
  resources :measures, only: [:new, :create, :edit, :update, :destroy], as: :performance_measures

  resources :sales_aids, except: :show do
    get 'download', on: :member, as: :download
  end
  get 'learn-more', to: 'sales_aids#index', as: :learn_more

  resources :sessions, only: [:new, :create, :destroy]
  resource :password_reset, only: [:new, :create, :edit, :update]

  get 'login', to: 'sessions#new', as: :login
  delete 'logout', to: 'sessions#destroy', as: :logout

  root to: 'pages#welcome'
end
