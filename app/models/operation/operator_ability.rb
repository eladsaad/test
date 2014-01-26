class Operation::OperatorAbility

  include CanCan::Ability

  def initialize(operator)
    
    unless operator.nil?
    	
    	# own account
    	can [:read, :edit, :update], Operator, id: operator.id

    	# player groups
    	can [:read, :create, :edit, :update], PlayerGroup, operator_id: operator.id
    	can [:new, :index], PlayerGroup

    	# player organizations
    	can [:read, :create, :edit, :update], PlayerOrganization, operator_id: operator.id
    	can [:new, :index], PlayerOrganization

      # registration codes
      can :reg_codes, Operator, id: operator.id

      # operator mobile stations
      can [:read, :create, :edit, :update], OperatorMobileStation, operator_id: operator.id
      can [:new, :index], OperatorMobileStation

    end

  end

end