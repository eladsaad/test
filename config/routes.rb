Cinemadrive::Application.routes.draw do

  # / - basic site
  devise_for :players, :controllers => {
      :sessions => 'players/sessions',
      :passwords => 'players/passwords',
      :confirmations => 'players/confirmations',
      :registrations => 'players/registrations',
      :omniauth_callbacks => "players/omniauth_callbacks"
    }
  root :to => "players#dashboard"
  get '/dashboard' => "players#dashboard", :as => :player_dashboard
  resources :player_group_associations, only: [:new, :create]

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
        get :edit_questions
        put :add_question
        put :remove_question
        get :new_question
        post :create_question
      end
    end
    resources :notifications
    #resources :images
    resources :videos
    resources :language_codes
    resources :interactive_videos do
      member do
        get :content
      end
    end
  end

  # /operation - operators administration
  namespace :operation do
    devise_for :operators, :controllers => {
      :sessions => 'operation/operators/sessions',
      :passwords => 'operation/operators/passwords',
      :confirmations => 'operation/operators/confirmations'
    }
    root :to => "player_groups#index"
    resources :player_organizations, only: [:index, :show, :new, :edit, :create, :update]
    resources :player_groups, only: [:index, :show, :new, :edit, :create, :update]
    resources :operator_mobile_stations
    get '/registration_codes/fetch/:amount' => "registration_codes#fetch", :as => :fetch_registration_codes
  end

end
