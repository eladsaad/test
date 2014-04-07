class Operation::PlayerGroupsController < Operation::OperationController
  before_action :set_operation_player_group, only: [:show, :edit, :update, :destroy]

  allowed_sort_columns Operation::PlayerGroup

  set_pagination_headers :operation_player_groups, only: [:index]

  # GET /operation/player_groups
  # GET /operation/player_groups.json
  def index
    authorize! :index, PlayerGroup
    @operation_player_groups = Operation::PlayerGroup.accessible_by(current_ability, :read)
    @operation_player_groups = @operation_player_groups.search(params[:search]) unless params[:search].blank?
    @operation_player_groups = @operation_player_groups.where('screening_date >= ?',params[:screening_date_from]) unless params[:screening_date_from].blank?
    @operation_player_groups = @operation_player_groups.where('screening_date <= ?',params[:screening_date_to]) unless params[:screening_date_to].blank?
    @operation_player_groups = @operation_player_groups.order("#{sort_column} #{sort_direction}") unless sort_column.blank?
    @operation_player_groups = @operation_player_groups.paginate(page: params[:page], per_page: params[:per_page] || 100)
  end
  
  # GET /operation/player_groups/1
  # GET /operation/player_groups/1.json
  def show
    authorize! :read, @operation_player_group
  end

  # GET /operation/player_groups/new
  def new
    authorize! :new, PlayerGroup
    @operation_player_group = Operation::PlayerGroup.new
    @operation_player_group.operator_id = current_operation_operator.id
    @operation_player_group.build_extension_params
  end

  # GET /operation/player_groups/1/edit
  def edit
    authorize! :edit, @operation_player_group
    @operation_player_group.build_extension_params unless @operation_player_group.extension_params
  end

  # POST /operation/player_groups
  # POST /operation/player_groups.json
  def create
    @operation_player_group = Operation::PlayerGroup.new(operation_player_group_params)
    @operation_player_group.operator_id = current_operation_operator.id
    @operation_player_group.reg_code = current_operation_operator.fetch_registration_codes.last if @operation_player_group.reg_code.blank?
    authorize! :create, @operation_player_group

    respond_to do |format|
      if @operation_player_group.save
        format.html { redirect_to @operation_player_group, notice: 'Group was successfully created.' }
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
    authorize! :update, @operation_player_group
    respond_to do |format|
      if @operation_player_group.update(operation_player_group_params)
        format.html { redirect_to @operation_player_group, notice: 'Group was successfully updated.' }
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
    authorize! :destroy, @operation_player_group
    @operation_player_group.soft_delete!
    respond_to do |format|
      format.html { redirect_to operation_player_groups_path }
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
      params.require(:operation_player_group).permit(
        :reg_code,
        :screening_date,
        :name, :description,
        :player_organization_id,
        :mobile_station_code,
        :online_program_id,
        :extension_params_attributes => [
          :custom_01, :custom_02, :custom_03, :custom_04, :custom_05,
          :custom_06, :custom_07, :custom_08, :custom_09, :custom_10
        ]
      )
    end

    
      
    
end
