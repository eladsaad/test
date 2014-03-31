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
  get '/about' => "static_pages#about"
  get '/terms' => "static_pages#terms"
  get '/points_n_prizes' => "scores#index"
  get '/accept_tos' => 'players#edit_accept_tos', :as => "edit_accept_tos_player"
  put '/accept_tos' => 'players#update_accept_tos', :as => "update_accept_tos_player"

  get '/confirm_reg' => "static_pages#confirm_reg"

  resources :notifications, only: [] do
    member do
      post :facebook
      get :facebook
    end
  end

  get '/invite' => "player_invite#invite"
  put '/invite' => "player_invite#send_invite"

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
      resources :sessions, only: [:create, :destroy]
      resources :surveys, only: [:show, :post]
      resources :interactive_videos, only: [:index, :show]
      resources :scores, only: [:show]
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
    resources :surveys do
      member do
        put :add_question
        put :remove_question
      end
    end
    resources :notifications
    resources :images
    resources :videos
    resources :language_codes
    resources :interactive_videos
    resources :online_programs
    resources :campaigns
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
