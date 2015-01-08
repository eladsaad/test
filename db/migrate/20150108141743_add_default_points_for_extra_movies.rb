class AddDefaultPointsForExtraMovies < ActiveRecord::Migration
  def change
    current_settings = AppSettings.player_score_update_points
    AppSettings.player_score_update_points = current_settings.merge({
                                                                      extra_for_first_movie: 0,
                                                                      extra_for_second_movie: 10,
                                                                      extra_for_third_movie: 20,
                                                                      extra_for_fourth_movie: 30,
                                                                      extra_for_fifth_movie: 40,
                                                                      extra_for_sixth_movie: 50,
                                                                    })
  end
end
