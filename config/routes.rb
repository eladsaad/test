Cinemadrive::Application.routes.draw do

  root :to => "players#index"
  resources :players

  # /admin - system administration
  namespace :admin do
    root :to => "operators#index"
    resources :system_admins
    resources :operators
  end

  # /operation - operators administration
  namespace :operation do
    root :to => "player_groups#index"
    resources :player_organizations
    resources :player_groups
  end

end
