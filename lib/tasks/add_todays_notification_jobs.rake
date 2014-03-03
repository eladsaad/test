namespace :notifications do
  desc "Add notifcation jobs for the current hour"
  task add_notification_jobs: :environment do

    start_time = ENV["START_TIME"] || Time.now
    end_time = ENV["END_TIME"] || start_time + 1.hour


    PlayerGroups.all.each do |group|

      logger.debug "Working on group id [#{group.id}"

      if !group.active?
        logger.debug "Group id [#{group.id}] is not active"
      else

        # get today's notifications
        days_since_start = (Date.today - player_group.screening_date).to_i
        todays_program_notifications = group.online_program.online_program_notifications
        todays_program_notifications = todays_program_notifications.where(
          'start_after_days = ? and start_time > ? and start_time <= ?', days_since_start, start_time, end_time
        )
        todays_program_notifications = todays_program_notifications.include(:notification)
        
        logger.debug "Found [#{todays_notifications.size} notifications for today for group id [#{group.id}]]"
        
        todays_program_notifications.each do |program_notification|

          # schedule email notificaitons for all players
          if email_content = program_notification.notification.email_content
            group.players.pluck(:email).each do |player_email|
              Delayed::Job.enqueue EmailNotificationJob.new(player_email, email_content)
            end
          end

          # schedule facebook notificaitons for all players
          if facebook_content = program_notification.notification.facebook_content
            callback_url = ??? # TODO: implement
            group.players.pluck(:id).each do |player_id|
              Delayed::Job.enqueue FacebookNotificationJob.new(player_id, facebook_content callback_url)
            end
          end 

        end

      end

    end

  end
end
