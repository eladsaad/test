class Admin::PlayersController < Admin::AdminController
  before_action :set_admin_player, only: [:show, :edit, :update, :destroy]

  allowed_sort_columns Admin::Player

  set_pagination_headers :admin_players, only: [:index]

  # GET /admin/players
  # GET /admin/players.json
  def index
    authorize! :index, Player
    @admin_players = Admin::Player.accessible_by(current_ability, :read).includes(:player_group)
    @admin_players = @admin_players.search(params[:search]) unless params[:search].blank?
    @admin_players = @admin_players.order("#{sort_column} #{sort_direction}") unless sort_column.blank?
    @admin_players = @admin_players.paginate(page: params[:page], per_page: params[:per_page] || 100)
  end

  # GET /admin/players/1
  # GET /admin/players/1.json
  def show
    authorize! :read, @admin_player
  end

  # # GET /admin/players/1/edit
  # def edit
  #   authorize! :edit, @admin_player
  # end

  # # PATCH/PUT /admin/players/1
  # # PATCH/PUT /admin/players/1.json
  # def update
  #   authorize! :update, @admin_player

  #   respond_to do |format|
  #     if @admin_player.update(admin_player_params)
  #       format.html { redirect_to @admin_player, notice: 'Player was successfully updated.' }
  #       format.json { head :no_content }
  #     else
  #       format.html { render action: 'edit' }
  #       format.json { render json: @admin_player.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /admin/players/1
  # DELETE /admin/players/1.json
  def destroy
    authorize! :destroy, @admin_player
    @admin_player.destroy
    respond_to do |format|
      format.html { redirect_to admin_players_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_player
      @admin_player = Admin::Player.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_player_params
      params.require(:admin_player).permit(:email, :first_name, :last_name, :birth_date, :gender, :profile_picture, :age)
    end

end
