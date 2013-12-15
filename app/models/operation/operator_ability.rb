class Operation::OperatorAbility

  include CanCan::Ability

  def initialize(operator)
    
    unless operator.nil?
    	
    	# own account
    	can [:read, :edit, :update], Operator, id: operator.id

    	# player groups
    	can [:read, :edit, :update, :destroy], PlayerGroup, operator_id: operator.id
    	can [:new, :create, :index], PlayerGroup

    	# player organizations
    	can [:read, :edit, :update, :destroy], PlayerOrganization, operator_id: operator.id
    	can [:new, :create, :index], PlayerOrganization

	end

  end

end