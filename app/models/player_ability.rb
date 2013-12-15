class PlayerAbility

  include CanCan::Ability

  def initialize(player)
    
    can :manage, Player # TEMPORARY - REMOVE!

  end

end