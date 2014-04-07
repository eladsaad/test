class PlayerAbility

  include CanCan::Ability

  def initialize(player)
    
    can :read, :player_dashboard

    can :new, PlayerGroupAssociation
    can :create, PlayerGroupAssociation, player_id: player.id

    can :index, InteractiveVideo
    can :read, InteractiveVideo do |interactive_video|
      interactive_video.allowed_for_player(player)
    end

    can :read, Notification do |notification|
      notification.allowed_for_player(player)
    end

    can :index, OnlineProgramInteractiveVideo

    can :click, Campaign

    can :accept_tos, Player, id: player.id

    can :index, Score

    can :read, Survey

    can :read, Question

    can :read, PlayerAnswer
    can :create, PlayerAnswer
    can :update, PlayerAnswer

    can :send, :invite

  end

end