class AddDefaultPointsForExtraForMovie < ActiveRecord::Migration
  def change
    current_settings = AppSettings.player_score_update_points
    AppSettings.player_score_update_points = current_settings.merge({extra_for_movie: 10})
  end
end
