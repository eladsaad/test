class Operation::PlayerGroupsController < Operation::OperationController
  before_action :set_operation_player_group, only: [:show, :edit, :update, :destroy]

  # GET /operation/player_groups
  # GET /operation/player_groups.json
  def index
    @operation_player_groups = Operation::PlayerGroup.all
  end

  # GET /operation/player_groups/1
  # GET /operation/player_groups/1.json
  def show
  end

  # GET /operation/player_groups/new
  def new
    @operation_player_group = Operation::PlayerGroup.new
  end

  # GET /operation/player_groups/1/edit
  def edit
  end

  # POST /operation/player_groups
  # POST /operation/player_groups.json
  def create
    @operation_player_group = Operation::PlayerGroup.new(operation_player_group_params)

    respond_to do |format|
      if @operation_player_group.save
        format.html { redirect_to @operation_player_group, notice: 'Player group was successfully created.' }
        format.json { render action: 'show', status: :created, location: @operation_player_group }
      else
        format.html { render action: 'new' }
        format.json { render json: @operation_player_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /operation/player_groups/1
  # PATCH/PUT /operation/player_groups/1.json
  def update
    respond_to do |format|
      if @operation_player_group.update(operation_player_group_params)
        format.html { redirect_to @operation_player_group, notice: 'Player group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @operation_player_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /operation/player_groups/1
  # DELETE /operation/player_groups/1.json
  def destroy
    @operation_player_group.destroy
    respond_to do |format|
      format.html { redirect_to operation_player_groups_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_operation_player_group
      @operation_player_group = Operation::PlayerGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def operation_player_group_params
      params.require(:operation_player_group).permit(:reg_code, :program_start_date, :name, :description, :player_organization_id)
    end
end
