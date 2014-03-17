namespace :notifications do
  desc "Add notifcation jobs since last execution time"
  task :add_jobs => :environment do

    # get last execution time
    last_execution_timestamp = ENV['last_execution_timestamp']
    last_execution_timestamp = Time.at last_execution_timestamp.to_i unless last_execution_timestamp.blank?
    last_execution_timestamp ||= AppSettings.last_execution_timestamp
    if last_execution_timestamp.blank?
      raise "ERROR - 'last_execution_timestamp' missing from AppSettings and not provided as argument"
    end

    last_execution_date = last_execution_timestamp.to_date
    last_execution_time = last_execution_timestamp.strftime("%H:%M:%S")

    # get current execution time
    current_execution_timestamp = Time.now
    current_execution_date = current_execution_timestamp.to_date
    current_execution_time = current_execution_timestamp.strftime("%H:%M:%S")


    # -------------------------------------

    PlayerGroup.all.each do |group|

      puts "Working on group id [#{group.id}]"

      if !group.active?
        puts "Group id [#{group.id}] is not active"
      else

        # get relevant notifications
        days_from  = (last_execution_date - group.screening_date).to_i
        days_until = (current_execution_date - group.screening_date).to_i

        program_notifications = group.online_program.online_program_notifications.where(
          "(start_after_days >= :days_from and start_after_days < :days_until) or " +
          "(start_after_days = :days_until and start_time > :last_execution_time and start_time <= :current_execution_time)",
          
          days_from: days_from,
          days_until: days_until,
          last_execution_time: last_execution_time,
          current_execution_time: current_execution_time
        )

        program_notifications = program_notifications.includes(:notification)
        
        puts "Found [#{program_notifications.size}] notifications for group id [#{group.id}]"
        
        program_notifications.each do |program_notification|

          # schedule email notificaitons for all players
          email_content = program_notification.notification.email_content
          email_subject = program_notification.notification.title
          unless email_content.blank?
            group.players.each do |player|
              parsed_email_content = Notification.parse_text(email_content, player)
              parsed_email_subject = Notification.parse_text(email_subject, player)
              puts "Adding email job for email [#{player.email}]"
              Delayed::Job.enqueue EmailNotificationJob.new(player.email, parsed_email_subject, parsed_email_content)
            end
          end

          # schedule facebook notificaitons for all players
          facebook_content = program_notification.notification.facebook_content
          unless facebook_content.blank?
            callback_url = nil # TODO: implement
            group.players.each do |player|
              parsed_facebook_content = Notification.parse_text(facebook_content, player)
              facebook_user_id = PlayerAuthentication.find_by_provider_and_player_id(:facebook, player.id).try(:uid)
              if facebook_user_id.blank?
                puts "Missing facebook id for player id [#{player.id}]"
              else
                puts "Adding facebook job for player id [#{player.id}]"
                Delayed::Job.enqueue FacebookNotificationJob.new(facebook_user_id, parsed_facebook_content, callback_url)
              end
            end
          end 

        end

      end

    end

    # -------------------------------------

    # save current execution time
    AppSettings.last_execution_timestamp = current_execution_timestamp

    puts 'Done'

  end
end
