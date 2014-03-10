class ScoresController < BaseController
  include ActionView::Helpers::NumberHelper

  def index
    authorize! :read, Score

    @player_score = number_with_delimiter(current_player.score)
    @group_score = number_with_delimiter(current_player_group.score)
  end

end
