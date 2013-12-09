Cinemadrive::Application.routes.draw do

  # / - basic site
  devise_for :players
  root :to => "players#index"
  resources :players

  # /admin - system administration
  namespace :admin do
    devise_for :system_admins, :controllers => {
      :sessions => 'admin/system_admin_sessions',
      :passwords => 'admin/system_admin_passwords',
      :confirmations => 'admin/system_admin_confirmations'
    }
    root :to => "operators#index"
    resources :system_admins
    resources :operators
  end

  # /operation - operators administration
  namespace :operation do
    devise_for :operators, :controllers => {
      :sessions => 'operation/operator_sessions',
      :passwords => 'operation/operator_passwords',
      :confirmations => 'operation/operator_confirmations'
    }
    root :to => "player_groups#index"
    resources :player_organizations
    resources :player_groups
  end

end
