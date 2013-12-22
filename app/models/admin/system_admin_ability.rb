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
    	
	end

  end

end