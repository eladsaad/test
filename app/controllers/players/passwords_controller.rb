class Players::PasswordsController < Devise::PasswordsController
  respond_to :html, :js
end