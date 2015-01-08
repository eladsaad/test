class RemoveDefaultPointsForExtraForMovie < ActiveRecord::Migration
  def change
    AppSettings.player_score_update_points.delete(:extra_for_movie)
  end
end
