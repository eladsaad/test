namespace :db do
  desc "Adding language codes"
  task add_language_codes: :environment do

    # get parameters
    email = ENV['email']
    first_name = ENV['first_name']
    last_name = ENV['last_name']
    password = ENV['password']

    # check parameter validity
    if email.blank? or first_name.blank? or last_name.blank? or password.blank?
      puts "Usage is rake db:add_system_admin email=EMAIL_HERE first_name=FIRST_NAME_HERE last_name=LAST_NAME_HERE password=PASSWORD_HERE"
    else
      # add new system_admin
      system_admin = SystemAdmin.find_by_email(email)
      if system_admin.nil?
        system_admin = SystemAdmin.new
        system_admin.email = email
        system_admin.first_name = first_name
        system_admin.last_name = last_name
        system_admin.super_admin = true
        system_admin.password = password
        system_admin.save!
      else
        # email already used
        puts "The email [#{email}] is already used"
      end
    end

  end
end
