
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


== RAKE TASKS

The following tasks are available:

* db:add_super_system_admin
* db:fill_reg_codes
* notifications:add_jobs


== HEROKU

Execute this before applying environment variables:

* heroku labs:enable user-env-compile