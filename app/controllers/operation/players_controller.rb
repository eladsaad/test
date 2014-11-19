class Operation::PlayersController < Operation::OperationController
  before_action :set_operation_player, only: [:show, :edit, :update, :destroy]

  allowed_sort_columns Operation::Player

  set_pagination_headers :operation_players, only: [:index]

  # GET /admin/players
  # GET /admin/players.json
  def index
    authorize! :index, Player
    @operation_players = Operation::Player.accessible_by(current_ability, :read).includes(:player_group)
    @operation_players = @operation_players.search(params[:search]) unless params[:search].blank?
    @operation_players = @operation_players.where(player_group_id: params[:player_group_id]) unless params[:player_group_id].blank?
    @operation_players = @operation_players.order("#{sort_column} #{sort_direction}") unless sort_column.blank?
    @operation_players = @operation_players.paginate(page: params[:page], per_page: params[:per_page] || 100)
  end

  # GET /admin/players/1
  # GET /admin/players/1.json
  def show
    authorize! :read, @operation_player
  end

  # # GET /admin/players/1/edit
  # def edit
  #   authorize! :edit, @operation_player
  # end

  # # PATCH/PUT /admin/players/1
  # # PATCH/PUT /admin/players/1.json
  # def update
  #   authorize! :update, @operation_player

  #   respond_to do |format|
  #     if @operation_player.update(operation_player_params)
  #       format.html { redirect_to @operation_player, notice: 'Player was successfully updated.' }
  #       format.json { head :no_content }
  #     else
  #       format.html { render action: 'edit' }
  #       format.json { render json: @operation_player.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /admin/players/1
  # DELETE /admin/players/1.json
  def destroy
    authorize! :destroy, @operation_player
    @operation_player.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_operation_player
      @operation_player = Operation::Player.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def operation_player_params
      params.require(:operation_player).permit(:email, :first_name, :last_name, :birth_date, :gender, :profile_picture, :age)
    end

end
