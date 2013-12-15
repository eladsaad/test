class Admin::SystemAdminAbility

  include CanCan::Ability

  def initialize(system_admin)

    unless system_admin.nil?
    	
    	# system admins
    	can :manage, SystemAdmin

    	# operators
    	can :manage, Operator    	 
    	
	end

  end

end