class EmailNotificationJob < Struct.new(:email, :content)
  def perform
    # TODO: implement

    last_created_job_time = DelayedJobs.order(:created_at).last.try(:created_at) or 0

    

  end
end