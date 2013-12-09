Cinemadrive::Application.routes.draw do

  # /admin - system administration
  namespace :admin do
    resources :system_admins
    resources :operators
  end

  # /operation - operators administration
  namespace :operation do
    resources :player_organizations
    resources :player_groups
  end

end
