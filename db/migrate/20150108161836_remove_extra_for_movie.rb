class RemoveExtraForMovie < ActiveRecord::Migration
  def change
    current_player_score_update_points = AppSettings.player_score_update_points
    current_player_score_update_points.delete(:extra_for_movie)
    AppSettings.player_score_update_points = current_player_score_update_points
  end
end
