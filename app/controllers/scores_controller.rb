class ScoresController < BaseController
  include ActionView::Helpers::NumberHelper

  def index
    authorize! :read, current_player

    @player_score = number_with_delimiter(current_player.score)
    @group_score = number_with_delimiter(current_player_group.relative_score)
    @group_name = current_player_group.name
    @group_count = current_player_group.players.count

  end

end
