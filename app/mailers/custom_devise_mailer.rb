class CustomDeviseMailer < Devise::Mailer   
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url

  after_filter :reset_api_version

  @@use_api_version = false

  def self.use_api_version!
  	@@use_api_version = true
  end

  def self.api_version?
  	@@use_api_version
  end

  protected

  	def reset_api_version
  		@@use_api_version = false
	end

end