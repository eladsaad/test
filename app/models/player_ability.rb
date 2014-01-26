class PlayerAbility

  include CanCan::Ability

  def initialize(player)
    
    can :read, :player_dashboard

    can :new, PlayerGroupAssociation
    can :create, PlayerGroupAssociation, player_id: player.id

  end

end