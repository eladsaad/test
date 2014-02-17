class PlayerAbility

  include CanCan::Ability

  def initialize(player)
    
    can :read, :player_dashboard

    can :new, PlayerGroupAssociation
    can :create, PlayerGroupAssociation, player_id: player.id

    can :read, InteractiveVideo # TODO: player can view only interactive video's related to program he's subscribed to
      # and only in case the group not expired

  end

end