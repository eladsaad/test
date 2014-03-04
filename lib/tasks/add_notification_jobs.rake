namespace :notifications do
  desc "Add notifcation jobs since last execution time"
  task :add_jobs => :environment do

    # get last execution time
    last_execution_timestamp = ENV['last_add_notification_jobs_time']
    last_execution_timestamp = Time.at last_execution_timestamp.to_i unless last_execution_timestamp.blank?
    last_execution_timestamp ||= AppSettings.last_add_notification_jobs_time
    if last_execution_timestamp.blank?
      raise "ERROR - 'last_add_notification_jobs_time' missing from AppSettings and not provided as argument"
    end

    last_execution_date = last_execution_timestamp.to_date
    last_execution_time = last_execution_timestamp.strftime("%H:%M:%S")

    # get current execution time
    current_execution_timestamp = Time.now
    current_execution_date = current_execution_timestamp.to_date
    current_execution_time = current_execution_timestamp.strftime("%H:%M:%S")


    # -------------------------------------

    PlayerGroup.all.each do |group|

      puts "Working on group id [#{group.id}"

      if !group.active?
        puts "Group id [#{group.id}] is not active"
      else

        # get relevant notifications
        days_from  = (last_execution_date - group.screening_date).to_i
        days_until = (current_execution_date - group.screening_date).to_i

        program_notifications = group.online_program.online_program_notifications.where(
          'start_after_days >= ? and start_after_days <= ? and start_time > ? and start_time <= ?',
          days_from, days_until, last_execution_time, current_execution_time
        )

        program_notifications = program_notifications.includes(:notification)
        
        puts "Found [#{program_notifications.size}] notifications for group id [#{group.id}]"
        
        program_notifications.each do |program_notification|

          # schedule email notificaitons for all players
          email_content = program_notification.notification.email_content
          unless email_content.blank?
            group.players.pluck(:email).each do |player_email|
              puts "Adding email job for email [#{player_email}]"
              Delayed::Job.enqueue EmailNotificationJob.new(player_email, email_content)
            end
          end

          # schedule facebook notificaitons for all players
          facebook_content = program_notification.notification.facebook_content
          unless facebook_content.blank?
            callback_url = nil # TODO: implement
            group.players.pluck(:id).each do |player_id|
              facebook_user_id = PlayerAuthentication.find_by_provider_and_player_id(:facebook, player_id).try(:uid)
              if facebook_user_id.blank?
                puts "Missing facebook id for player id [#{player_id}]"
              else
                puts "Adding facebook job for player id [#{player_id}]"
                Delayed::Job.enqueue FacebookNotificationJob.new(facebook_user_id, facebook_content, callback_url)
              end
            end
          end 

        end

      end

    end

    # -------------------------------------

    # save current execution time
    AppSettings.last_add_notification_jobs_time = current_execution_timestamp

    puts 'Done'

  end
end
