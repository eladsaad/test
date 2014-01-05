class PlayersController < BaseController
  before_action :set_player, only: [:show, :edit, :update, :destroy]


  def join_group
    authorize! :join_group, PlayerGroup
    given_reg_code = params[:reg_code]
    group = PlayerGroup.where(reg_code: given_reg_code)
    group.add_player(current_player)
    
  end

  # GET /players
  # GET /players.json
  def index
    authorize! :index, Player
    @players = Player.all
  end

  # GET /players/1
  # GET /players/1.json
  def show
    authorize! :read, @player
  end

  # GET /players/new
  def new
    @player = Player.new
    authorize! :new, Player
  end

  # GET /players/1/edit
  def edit
    authorize! :edit, @player
  end

  # POST /players
  # POST /players.json
  def create
    @player = Player.new(player_params)
    authorize! :create, @player

    respond_to do |format|
      if @player.save
        format.html { redirect_to @player, notice: 'Player was successfully created.' }
        format.json { render action: 'show', status: :created, location: @player }
      else
        format.html { render action: 'new' }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /players/1
  # PATCH/PUT /players/1.json
  def update
    authorize! :update, @player
    respond_to do |format|
      if @player.update(player_params)
        format.html { redirect_to @player, notice: 'Player was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1
  # DELETE /players/1.json
  def destroy
    authorize! :destroy, @player
    @player.destroy
    respond_to do |format|
      format.html { redirect_to players_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_params
      params.require(:player).permit(:username, :email, :first_name, :last_name, :birth_date)
    end
end
