require 'api_constraints'

Cinemadrive::Application.routes.draw do

  # -------------------------------
  # main site
  # -------------------------------

  devise_for :players, :path => '', :controllers => {
      :sessions => 'players/sessions',
      :passwords => 'players/passwords',
      :confirmations => 'players/confirmations',
      :registrations => 'players/registrations',
      :omniauth_callbacks => "players/omniauth_callbacks"
  }
  devise_scope :player do
    get '/registrations/pre_sign_up' => 'players/registrations#pre_sign_up', :as => :player_pre_sign_up
    get '/registrations/check_reg_code' => 'players/registrations#check_reg_code', :as => :player_check_reg_code
  end
  
  get '/campaigns/click/:id' => "campaigns#click", :as => :click_campaign
  resources :interactive_videos, only: [:index, :show] do
    member do
      get :content
      get :post_interactive
    end
  end
  root :to => "static_pages#welcome"
  get '/mobile' => "static_pages#mobile", :as => :mobile_root 
  get '/about' => "static_pages#about"
  get '/terms' => "static_pages#terms"
  get '/terms_modal' => "static_pages#terms_modal"
  get '/points_n_prizes' => "scores#index"

  get '/confirm_reg' => "static_pages#confirm_reg"

  resources :notifications, only: [] do
    member do
      post :facebook
      get :facebook
    end
  end

  get '/invites' => "player_invites#invite"
  put '/invites' => "player_invites#send_invite"

  resources :surveys, only: [:show] do
    member do
      put :post_answers
    end
  end

  # -------------------------------
  # API
  # -------------------------------

  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: :true) do
      post 'sessions' => 'sessions#create'
      delete 'sessions' => 'sessions#destroy'
      resources :registrations, only: [:create] do
        collection do
          get :current
        end
      end
      post 'password', to: 'passwords#create'
      put 'password', to: 'passwords#update'
      get 'auth/:provider/callback', to: 'omniauth_callbacks#facebook'
      post 'auth/:provider/callback', to: 'omniauth_callbacks#facebook'
      resources :interactive_videos, only: [:index, :show] do
        member do
          post :done
        end
      end
      resources :surveys, only: [:show] do
        resources :answers, only: [:create], controller: :survey_answers
      end
      resources :scores, only: [:index]
      resources :campaigns, only: [] do
        member do
          get :click
        end
        collection do
          get :current
        end
      end
      resources :invites, only: [:create]
      resources :registration_codes, only: [] do
        collection do
          post :verify
        end
      end
    end
  end

  
  # -------------------------------
  # /admin - system administration
  # -------------------------------

  namespace :admin do
    devise_for :system_admins, :controllers => {
      :sessions => 'admin/system_admins/sessions',
      :passwords => 'admin/system_admins/passwords',
      :confirmations => 'admin/system_admins/confirmations'
    }
    root :to => "operators#index"
    resources :system_admins
    resources :operators do
      member do
        get :impersonate
      end
    end
    resources :questions
    resources :surveys
    resources :notifications
    resources :images
    resources :videos
    resources :language_codes
    resources :interactive_videos
    resources :online_programs
    resources :campaigns
    resources :players, only: [:index, :show, :destroy]
    resources :score_updates, only: [] do
        collection do
          get :edit
          post :update
        end
      end
  end


  # -------------------------------
  # /operation - operators administration
  # -------------------------------

  namespace :operation do
    devise_for :operators, :controllers => {
      :sessions => 'operation/operators/sessions',
      :passwords => 'operation/operators/passwords',
      :confirmations => 'operation/operators/confirmations'
    }
    root :to => "player_groups#index"
    resources :player_organizations
    resources :player_groups
    resources :operator_mobile_stations
    get '/registration_codes/fetch/:amount' => "registration_codes#fetch", :as => :fetch_registration_codes
  end

end
