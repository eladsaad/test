# == Route Map
#
#                                 Prefix Verb     URI Pattern                                            Controller#Action
#                     new_player_session GET      /sign_in(.:format)                                     players/sessions#new
#                         player_session POST     /sign_in(.:format)                                     players/sessions#create
#                 destroy_player_session DELETE   /sign_out(.:format)                                    players/sessions#destroy
#              player_omniauth_authorize GET|POST /auth/:provider(.:format)                              players/omniauth_callbacks#passthru {:provider=>/facebook/}
#               player_omniauth_callback GET|POST /auth/:action/callback(.:format)                       players/omniauth_callbacks#(?-mix:facebook)
#                        player_password POST     /password(.:format)                                    players/passwords#create
#                    new_player_password GET      /password/new(.:format)                                players/passwords#new
#                   edit_player_password GET      /password/edit(.:format)                               players/passwords#edit
#                                        PATCH    /password(.:format)                                    players/passwords#update
#                                        PUT      /password(.:format)                                    players/passwords#update
#             cancel_player_registration GET      /cancel(.:format)                                      players/registrations#cancel
#                    player_registration POST     /                                                      players/registrations#create
#                new_player_registration GET      /sign_up(.:format)                                     players/registrations#new
#               edit_player_registration GET      /edit(.:format)                                        players/registrations#edit
#                                        PATCH    /                                                      players/registrations#update
#                                        PUT      /                                                      players/registrations#update
#                                        DELETE   /                                                      players/registrations#destroy
#                    player_confirmation POST     /confirmation(.:format)                                players/confirmations#create
#                new_player_confirmation GET      /confirmation/new(.:format)                            players/confirmations#new
#                                        GET      /confirmation(.:format)                                players/confirmations#show
#                     player_pre_sign_up GET      /registrations/pre_sign_up(.:format)                   players/registrations#pre_sign_up
#                  player_check_reg_code GET      /registrations/check_reg_code(.:format)                players/registrations#check_reg_code
#                         click_campaign GET      /campaigns/click/:id(.:format)                         campaigns#click
#              content_interactive_video GET      /interactive_videos/:id/content(.:format)              interactive_videos#content
#     post_interactive_interactive_video GET      /interactive_videos/:id/post_interactive(.:format)     interactive_videos#post_interactive
#                     interactive_videos GET      /interactive_videos(.:format)                          interactive_videos#index
#                      interactive_video GET      /interactive_videos/:id(.:format)                      interactive_videos#show
#                                   root GET      /                                                      static_pages#welcome
#                            mobile_root GET      /mobile(.:format)                                      static_pages#mobile
#                                  about GET      /about(.:format)                                       static_pages#about
#                                  terms GET      /terms(.:format)                                       static_pages#terms
#                            terms_modal GET      /terms_modal(.:format)                                 static_pages#terms_modal
#                        points_n_prizes GET      /points_n_prizes(.:format)                             scores#index
#                            confirm_reg GET      /confirm_reg(.:format)                                 static_pages#confirm_reg
#                  facebook_notification POST     /notifications/:id/facebook(.:format)                  notifications#facebook
#                                        GET      /notifications/:id/facebook(.:format)                  notifications#facebook
#                                invites GET      /invites(.:format)                                     player_invites#invite
#                                        PUT      /invites(.:format)                                     player_invites#send_invite
#                    post_answers_survey PUT      /surveys/:id/post_answers(.:format)                    surveys#post_answers
#                                 survey GET      /surveys/:id(.:format)                                 surveys#show
#                           api_sessions POST     /api/sessions(.:format)                                api/v1/sessions#create {:format=>"json"}
#                                        DELETE   /api/sessions(.:format)                                api/v1/sessions#destroy {:format=>"json"}
#              current_api_registrations GET      /api/registrations/current(.:format)                   api/v1/registrations#current {:format=>"json"}
#                      api_registrations POST     /api/registrations(.:format)                           api/v1/registrations#create {:format=>"json"}
#                           api_password POST     /api/password(.:format)                                api/v1/passwords#create {:format=>"json"}
#                                        PUT      /api/password(.:format)                                api/v1/passwords#update {:format=>"json"}
#                                    api GET      /api/auth/:provider/callback(.:format)                 api/v1/omniauth_callbacks#facebook {:format=>"json"}
#                                        POST     /api/auth/:provider/callback(.:format)                 api/v1/omniauth_callbacks#facebook {:format=>"json"}
#             done_api_interactive_video POST     /api/interactive_videos/:id/done(.:format)             api/v1/interactive_videos#done {:format=>"json"}
#                 api_interactive_videos GET      /api/interactive_videos(.:format)                      api/v1/interactive_videos#index {:format=>"json"}
#                  api_interactive_video GET      /api/interactive_videos/:id(.:format)                  api/v1/interactive_videos#show {:format=>"json"}
#                     api_survey_answers POST     /api/surveys/:survey_id/answers(.:format)              api/v1/survey_answers#create {:format=>"json"}
#                             api_survey GET      /api/surveys/:id(.:format)                             api/v1/surveys#show {:format=>"json"}
#                             api_scores GET      /api/scores(.:format)                                  api/v1/scores#index {:format=>"json"}
#                     click_api_campaign GET      /api/campaigns/:id/click(.:format)                     api/v1/campaigns#click {:format=>"json"}
#                  current_api_campaigns GET      /api/campaigns/current(.:format)                       api/v1/campaigns#current {:format=>"json"}
#                            api_invites POST     /api/invites(.:format)                                 api/v1/invites#create {:format=>"json"}
#          verify_api_registration_codes POST     /api/registration_codes/verify(.:format)               api/v1/registration_codes#verify {:format=>"json"}
#         new_admin_system_admin_session GET      /admin/system_admins/sign_in(.:format)                 admin/system_admins/sessions#new
#             admin_system_admin_session POST     /admin/system_admins/sign_in(.:format)                 admin/system_admins/sessions#create
#     destroy_admin_system_admin_session DELETE   /admin/system_admins/sign_out(.:format)                admin/system_admins/sessions#destroy
#            admin_system_admin_password POST     /admin/system_admins/password(.:format)                admin/system_admins/passwords#create
#        new_admin_system_admin_password GET      /admin/system_admins/password/new(.:format)            admin/system_admins/passwords#new
#       edit_admin_system_admin_password GET      /admin/system_admins/password/edit(.:format)           admin/system_admins/passwords#edit
#                                        PATCH    /admin/system_admins/password(.:format)                admin/system_admins/passwords#update
#                                        PUT      /admin/system_admins/password(.:format)                admin/system_admins/passwords#update
#        admin_system_admin_confirmation POST     /admin/system_admins/confirmation(.:format)            admin/system_admins/confirmations#create
#    new_admin_system_admin_confirmation GET      /admin/system_admins/confirmation/new(.:format)        admin/system_admins/confirmations#new
#                                        GET      /admin/system_admins/confirmation(.:format)            admin/system_admins/confirmations#show
#                             admin_root GET      /admin(.:format)                                       admin/operators#index
#                    admin_system_admins GET      /admin/system_admins(.:format)                         admin/system_admins#index
#                                        POST     /admin/system_admins(.:format)                         admin/system_admins#create
#                 new_admin_system_admin GET      /admin/system_admins/new(.:format)                     admin/system_admins#new
#                edit_admin_system_admin GET      /admin/system_admins/:id/edit(.:format)                admin/system_admins#edit
#                     admin_system_admin GET      /admin/system_admins/:id(.:format)                     admin/system_admins#show
#                                        PATCH    /admin/system_admins/:id(.:format)                     admin/system_admins#update
#                                        PUT      /admin/system_admins/:id(.:format)                     admin/system_admins#update
#                                        DELETE   /admin/system_admins/:id(.:format)                     admin/system_admins#destroy
#             impersonate_admin_operator GET      /admin/operators/:id/impersonate(.:format)             admin/operators#impersonate
#                        admin_operators GET      /admin/operators(.:format)                             admin/operators#index
#                                        POST     /admin/operators(.:format)                             admin/operators#create
#                     new_admin_operator GET      /admin/operators/new(.:format)                         admin/operators#new
#                    edit_admin_operator GET      /admin/operators/:id/edit(.:format)                    admin/operators#edit
#                         admin_operator GET      /admin/operators/:id(.:format)                         admin/operators#show
#                                        PATCH    /admin/operators/:id(.:format)                         admin/operators#update
#                                        PUT      /admin/operators/:id(.:format)                         admin/operators#update
#                                        DELETE   /admin/operators/:id(.:format)                         admin/operators#destroy
#                        admin_questions GET      /admin/questions(.:format)                             admin/questions#index
#                                        POST     /admin/questions(.:format)                             admin/questions#create
#                     new_admin_question GET      /admin/questions/new(.:format)                         admin/questions#new
#                    edit_admin_question GET      /admin/questions/:id/edit(.:format)                    admin/questions#edit
#                         admin_question GET      /admin/questions/:id(.:format)                         admin/questions#show
#                                        PATCH    /admin/questions/:id(.:format)                         admin/questions#update
#                                        PUT      /admin/questions/:id(.:format)                         admin/questions#update
#                                        DELETE   /admin/questions/:id(.:format)                         admin/questions#destroy
#                          admin_surveys GET      /admin/surveys(.:format)                               admin/surveys#index
#                                        POST     /admin/surveys(.:format)                               admin/surveys#create
#                       new_admin_survey GET      /admin/surveys/new(.:format)                           admin/surveys#new
#                      edit_admin_survey GET      /admin/surveys/:id/edit(.:format)                      admin/surveys#edit
#                           admin_survey GET      /admin/surveys/:id(.:format)                           admin/surveys#show
#                                        PATCH    /admin/surveys/:id(.:format)                           admin/surveys#update
#                                        PUT      /admin/surveys/:id(.:format)                           admin/surveys#update
#                                        DELETE   /admin/surveys/:id(.:format)                           admin/surveys#destroy
#                    admin_notifications GET      /admin/notifications(.:format)                         admin/notifications#index
#                                        POST     /admin/notifications(.:format)                         admin/notifications#create
#                 new_admin_notification GET      /admin/notifications/new(.:format)                     admin/notifications#new
#                edit_admin_notification GET      /admin/notifications/:id/edit(.:format)                admin/notifications#edit
#                     admin_notification GET      /admin/notifications/:id(.:format)                     admin/notifications#show
#                                        PATCH    /admin/notifications/:id(.:format)                     admin/notifications#update
#                                        PUT      /admin/notifications/:id(.:format)                     admin/notifications#update
#                                        DELETE   /admin/notifications/:id(.:format)                     admin/notifications#destroy
#                           admin_images GET      /admin/images(.:format)                                admin/images#index
#                                        POST     /admin/images(.:format)                                admin/images#create
#                        new_admin_image GET      /admin/images/new(.:format)                            admin/images#new
#                       edit_admin_image GET      /admin/images/:id/edit(.:format)                       admin/images#edit
#                            admin_image GET      /admin/images/:id(.:format)                            admin/images#show
#                                        PATCH    /admin/images/:id(.:format)                            admin/images#update
#                                        PUT      /admin/images/:id(.:format)                            admin/images#update
#                                        DELETE   /admin/images/:id(.:format)                            admin/images#destroy
#                           admin_videos GET      /admin/videos(.:format)                                admin/videos#index
#                                        POST     /admin/videos(.:format)                                admin/videos#create
#                        new_admin_video GET      /admin/videos/new(.:format)                            admin/videos#new
#                       edit_admin_video GET      /admin/videos/:id/edit(.:format)                       admin/videos#edit
#                            admin_video GET      /admin/videos/:id(.:format)                            admin/videos#show
#                                        PATCH    /admin/videos/:id(.:format)                            admin/videos#update
#                                        PUT      /admin/videos/:id(.:format)                            admin/videos#update
#                                        DELETE   /admin/videos/:id(.:format)                            admin/videos#destroy
#                   admin_language_codes GET      /admin/language_codes(.:format)                        admin/language_codes#index
#                                        POST     /admin/language_codes(.:format)                        admin/language_codes#create
#                new_admin_language_code GET      /admin/language_codes/new(.:format)                    admin/language_codes#new
#               edit_admin_language_code GET      /admin/language_codes/:id/edit(.:format)               admin/language_codes#edit
#                    admin_language_code GET      /admin/language_codes/:id(.:format)                    admin/language_codes#show
#                                        PATCH    /admin/language_codes/:id(.:format)                    admin/language_codes#update
#                                        PUT      /admin/language_codes/:id(.:format)                    admin/language_codes#update
#                                        DELETE   /admin/language_codes/:id(.:format)                    admin/language_codes#destroy
#               admin_interactive_videos GET      /admin/interactive_videos(.:format)                    admin/interactive_videos#index
#                                        POST     /admin/interactive_videos(.:format)                    admin/interactive_videos#create
#            new_admin_interactive_video GET      /admin/interactive_videos/new(.:format)                admin/interactive_videos#new
#           edit_admin_interactive_video GET      /admin/interactive_videos/:id/edit(.:format)           admin/interactive_videos#edit
#                admin_interactive_video GET      /admin/interactive_videos/:id(.:format)                admin/interactive_videos#show
#                                        PATCH    /admin/interactive_videos/:id(.:format)                admin/interactive_videos#update
#                                        PUT      /admin/interactive_videos/:id(.:format)                admin/interactive_videos#update
#                                        DELETE   /admin/interactive_videos/:id(.:format)                admin/interactive_videos#destroy
#                  admin_online_programs GET      /admin/online_programs(.:format)                       admin/online_programs#index
#                                        POST     /admin/online_programs(.:format)                       admin/online_programs#create
#               new_admin_online_program GET      /admin/online_programs/new(.:format)                   admin/online_programs#new
#              edit_admin_online_program GET      /admin/online_programs/:id/edit(.:format)              admin/online_programs#edit
#                   admin_online_program GET      /admin/online_programs/:id(.:format)                   admin/online_programs#show
#                                        PATCH    /admin/online_programs/:id(.:format)                   admin/online_programs#update
#                                        PUT      /admin/online_programs/:id(.:format)                   admin/online_programs#update
#                                        DELETE   /admin/online_programs/:id(.:format)                   admin/online_programs#destroy
#                        admin_campaigns GET      /admin/campaigns(.:format)                             admin/campaigns#index
#                                        POST     /admin/campaigns(.:format)                             admin/campaigns#create
#                     new_admin_campaign GET      /admin/campaigns/new(.:format)                         admin/campaigns#new
#                    edit_admin_campaign GET      /admin/campaigns/:id/edit(.:format)                    admin/campaigns#edit
#                         admin_campaign GET      /admin/campaigns/:id(.:format)                         admin/campaigns#show
#                                        PATCH    /admin/campaigns/:id(.:format)                         admin/campaigns#update
#                                        PUT      /admin/campaigns/:id(.:format)                         admin/campaigns#update
#                                        DELETE   /admin/campaigns/:id(.:format)                         admin/campaigns#destroy
#               edit_admin_score_updates GET      /admin/score_updates/edit(.:format)                    admin/score_updates#edit
#                    admin_score_updates POST     /admin/score_updates(.:format)                         admin/score_updates#update
#         new_operation_operator_session GET      /operation/operators/sign_in(.:format)                 operation/operators/sessions#new
#             operation_operator_session POST     /operation/operators/sign_in(.:format)                 operation/operators/sessions#create
#     destroy_operation_operator_session DELETE   /operation/operators/sign_out(.:format)                operation/operators/sessions#destroy
#            operation_operator_password POST     /operation/operators/password(.:format)                operation/operators/passwords#create
#        new_operation_operator_password GET      /operation/operators/password/new(.:format)            operation/operators/passwords#new
#       edit_operation_operator_password GET      /operation/operators/password/edit(.:format)           operation/operators/passwords#edit
#                                        PATCH    /operation/operators/password(.:format)                operation/operators/passwords#update
#                                        PUT      /operation/operators/password(.:format)                operation/operators/passwords#update
#        operation_operator_confirmation POST     /operation/operators/confirmation(.:format)            operation/operators/confirmations#create
#    new_operation_operator_confirmation GET      /operation/operators/confirmation/new(.:format)        operation/operators/confirmations#new
#                                        GET      /operation/operators/confirmation(.:format)            operation/operators/confirmations#show
#                         operation_root GET      /operation(.:format)                                   operation/player_groups#index
#         operation_player_organizations GET      /operation/player_organizations(.:format)              operation/player_organizations#index
#                                        POST     /operation/player_organizations(.:format)              operation/player_organizations#create
#      new_operation_player_organization GET      /operation/player_organizations/new(.:format)          operation/player_organizations#new
#     edit_operation_player_organization GET      /operation/player_organizations/:id/edit(.:format)     operation/player_organizations#edit
#          operation_player_organization GET      /operation/player_organizations/:id(.:format)          operation/player_organizations#show
#                                        PATCH    /operation/player_organizations/:id(.:format)          operation/player_organizations#update
#                                        PUT      /operation/player_organizations/:id(.:format)          operation/player_organizations#update
#                                        DELETE   /operation/player_organizations/:id(.:format)          operation/player_organizations#destroy
#  survey_report_operation_player_groups GET      /operation/player_groups/survey_report(.:format)       operation/player_groups#survey_report
#                operation_player_groups GET      /operation/player_groups(.:format)                     operation/player_groups#index
#                                        POST     /operation/player_groups(.:format)                     operation/player_groups#create
#             new_operation_player_group GET      /operation/player_groups/new(.:format)                 operation/player_groups#new
#            edit_operation_player_group GET      /operation/player_groups/:id/edit(.:format)            operation/player_groups#edit
#                 operation_player_group GET      /operation/player_groups/:id(.:format)                 operation/player_groups#show
#                                        PATCH    /operation/player_groups/:id(.:format)                 operation/player_groups#update
#                                        PUT      /operation/player_groups/:id(.:format)                 operation/player_groups#update
#                                        DELETE   /operation/player_groups/:id(.:format)                 operation/player_groups#destroy
#     operation_operator_mobile_stations GET      /operation/operator_mobile_stations(.:format)          operation/operator_mobile_stations#index
#                                        POST     /operation/operator_mobile_stations(.:format)          operation/operator_mobile_stations#create
#  new_operation_operator_mobile_station GET      /operation/operator_mobile_stations/new(.:format)      operation/operator_mobile_stations#new
# edit_operation_operator_mobile_station GET      /operation/operator_mobile_stations/:id/edit(.:format) operation/operator_mobile_stations#edit
#      operation_operator_mobile_station GET      /operation/operator_mobile_stations/:id(.:format)      operation/operator_mobile_stations#show
#                                        PATCH    /operation/operator_mobile_stations/:id(.:format)      operation/operator_mobile_stations#update
#                                        PUT      /operation/operator_mobile_stations/:id(.:format)      operation/operator_mobile_stations#update
#                                        DELETE   /operation/operator_mobile_stations/:id(.:format)      operation/operator_mobile_stations#destroy
#                      operation_players GET      /operation/players(.:format)                           operation/players#index
#                       operation_player GET      /operation/players/:id(.:format)                       operation/players#show
#                                        DELETE   /operation/players/:id(.:format)                       operation/players#destroy
#     operation_fetch_registration_codes GET      /operation/registration_codes/fetch/:amount(.:format)  operation/registration_codes#fetch
#

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
    resources :player_groups do
      collection do
        get :survey_report
      end
    end

    resources :operator_mobile_stations
    resources :players, only: [:index, :show, :destroy]
    get '/registration_codes/fetch/:amount' => "registration_codes#fetch", :as => :fetch_registration_codes
  end

end
