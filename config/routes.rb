Cinemadrive::Application.routes.draw do

  # main site
  devise_for :players, :controllers => {
      :sessions => 'players/sessions',
      :passwords => 'players/passwords',
      :confirmations => 'players/confirmations',
      :registrations => 'players/registrations',
      :omniauth_callbacks => "players/omniauth_callbacks"
  }
  devise_scope :player do
    get '/players/registrations/pre_sign_up' => 'players/registrations#pre_sign_up', :as => :player_pre_sign_up
  end
  
  get '/' => 'static_pages#welcome'

  resources :player_group_associations, only: [:new, :create]

  get '/dashboard' => "players#dashboard", :as => :player_dashboard

  get '/campaigns/click/:id' => "campaigns#click", :as => :click_campaign


  # /admin - system administration
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

  # /operation - operators administration
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
