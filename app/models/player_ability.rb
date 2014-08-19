class PlayerAbility

  include CanCan::Ability

  def initialize(player)
    
    can :read, :player_dashboard

    can :index, InteractiveVideo
    can :read, InteractiveVideo do |interactive_video|
      interactive_video.allowed_for_player?(player)
    end

    can :read, Notification do |notification|
      notification.allowed_for_player?(player)
    end

    can :read, Campaign
    can :click, Campaign

    can :accept_tos, Player, id: player.id

    can :read, Survey # todo: only if belongs to available program
    can :answer, Survey # todo: only if belongs to available program

    can :read, Question

    can :read, PlayerAnswer, player_id: player.id
    can :create, PlayerAnswer, player_id: player.id
    can :update, PlayerAnswer, player_id: player.id

    can :create, :invite

    can :destroy, PlayerApiKey, player_id: player.id

    can :read, Player, id: player.id

  end

end