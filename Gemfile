source 'https://rubygems.org'

ruby '2.0.0'

gem 'rails', '4.0.2'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'jquery-ui-rails' # used for autocomplete
gem 'jbuilder', '~> 1.2' # json builder
gem 'devise' # authentication
gem 'cancan' # authorization
gem 'omniauth-facebook' # authentication via facebook
gem 'koala'
gem 'will_paginate' # pagination
gem 'pg' # postgresql
gem 'simple_form'
gem 'nested_form'
# gem 'therubyracer', platforms: :ruby
gem 'swf_fu'
gem 'unicorn'
gem 'historyjs-rails'
gem 'bootbox-rails', '~>0.2'
gem 'delayed_job_active_record' # async jobs queue
gem 'daemons' # required by dealyed_jobs
gem 'rails-settings-cached', '0.3.1'
gem 'newrelic_rpm'
gem 'mobile-fu'
gem "paperclip", "~> 4.2"
gem 'aws-sdk', '~> 1.5.7'
gem 'httparty'


group :production do
	gem 'rails_12factor' # heroku logging and assets
	#gem 'rails_serve_static_assets'
	gem 'workless' # automatic scaling of worker dynos for delayed_job
end

group :development do
	gem 'better_errors' # error page with interactive console
	gem 'binding_of_caller'
	gem 'meta_request' # rails tab in chrome developer tools
	gem "seed_dump", "~> 3.1.0"
end

group :doc do
	gem 'sdoc', require: false
end



