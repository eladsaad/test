class PlayersController < BaseController

  # GET /players/dashboard
  def dashboard
    authorize! :read, :player_dashboard
  end

end
