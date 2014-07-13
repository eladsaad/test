class Admin::SystemAdminAbility

  include CanCan::Ability

  def initialize(system_admin)

    unless system_admin.nil?
    	
    	# system admins
      if (system_admin.super_admin)
        can :manage, SystemAdmin
      end

    	# operators
    	can :manage, Operator

      # questions
      can :manage, Question

      # surveys
      can :manage, Survey

      # notifications
      can :manage, Notification

      # language codes
      can :manage, LanguageCode

      # images
      can :manage, Image

      # videos
      can :manage, Video

      # interactive videos
      can :manage, InteractiveVideo

      # online programs
      can :manage, OnlineProgram

      # campaigns
      can :manage, Campaign

      # players
      can [:read, :destroy, :index], Player

    end

  end

end