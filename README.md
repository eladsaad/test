
== ENVIRONMENT VARIABLES

These variables should be set on production environment:

* HTTP_HOST
* SMTP_HOST (example: smtp.gmail.com)
* SMTP_PORT
* SMTP_DOMAIN (example: mail.google.com)
* SMTP_USERNAME
* SMTP_PASSWORD
* NOTIFICATION_MAIL_SENDER
* FACEBOOK_APP_ID
* FACEBOOK_APP_SECRET
* FACEBOOK_APP_ACCESS_TOKEN
* DEVISE_SECRET_KEY
* BASE_SECRET_KEY
* DATABASE_NAME
* DATABASE_USER_NAME
* DATABASE_USER_PASSWORD
* DATABASE_HOST
* DATABASE_PORT
* HEROKU_API_KEY - used on heroku by 'workless' gem (heroku auth:token)
* APP_NAME - used on heroku by 'workless' gem


== RAKE TASKS

The following tasks are available:

* db:add_super_system_admin - Creates a new super system admin account
* db:fill_reg_codes - Adds additional group registration codes to the database
* notifications:add_jobs - Adds delayed_job jobs for sending notifications - executed by heroku scheduler
* db:clean_api_keys - Deletes expired API keys from the database - executed by heroku scheduler


== HEROKU

Execute this before applying environment variables:

* heroku labs:enable user-env-compile