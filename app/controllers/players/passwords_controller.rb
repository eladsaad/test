class Players::PasswordsController < Devise::PasswordsController
  respond_to :html, :js

  after_filter :add_score_updates_to_flash
end