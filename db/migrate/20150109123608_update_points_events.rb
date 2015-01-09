class UpdatePointsEvents < ActiveRecord::Migration
  def change
    # Get current scores settings
    current_player_score_update_points = AppSettings.player_score_update_points
    #  Remove Play a movie later
    current_player_score_update_points.delete(:interactive_video_watch)
    #  Remove Play a movie - 24 hours opp
    current_player_score_update_points.delete(:interactive_video_watch_early)

    # Save new score settings
    AppSettings.player_score_update_points = current_player_score_update_points


    # Add early watch scores for 6 different events
    current_settings = AppSettings.player_score_update_points

    AppSettings.player_score_update_points = current_settings.merge({
                                                                        extra_for_first_movie: 30,
                                                                        extra_for_first_movie_early: 50,
                                                                        extra_for_second_movie_early: 30,
                                                                        extra_for_third_movie_early: 40,
                                                                        extra_for_fourth_movie_early: 50,
                                                                        extra_for_fifth_movie_early: 60,
                                                                        extra_for_sixth_movie_early: 70,
                                                                    })

  end
end
