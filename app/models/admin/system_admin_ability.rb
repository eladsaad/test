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

      # notifications
      can :manage, Image

      # notifications
      can :manage, Video

      # notifications
      can :manage, InteractiveVideo

    end

  end

end