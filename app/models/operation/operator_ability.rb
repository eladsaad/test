class Operation::OperatorAbility

  include CanCan::Ability

  def initialize(operator)
    
    unless operator.nil?
    	
    	# own account
    	can [:read, :edit, :update], Operator, id: operator.id

    	# player groups
    	can [:read, :edit, :update], PlayerGroup, operator_id: operator.id
    	can [:new, :create, :index], PlayerGroup

    	# player organizations
    	can [:read, :edit, :update], PlayerOrganization, operator_id: operator.id
    	can [:new, :create, :index], PlayerOrganization

      # registration codes
      can :reg_codes, Operator, id: operator.id

	end

  end

end