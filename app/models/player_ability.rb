class PlayerAbility

  include CanCan::Ability

  def initialize(player)
    
    can :manage, Player # TEMPORARY - REMOVE!

    can :new, PlayerGroupAssociation
    can :create, PlayerGroupAssociation, player_id: player.id

  end

end