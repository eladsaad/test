class Operation::PlayerOrganizationsController < Operation::OperationController
  before_action :set_operation_player_organization, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction

  # GET /operation/player_organizations
  # GET /operation/player_organizations.json
  def index
    authorize! :index, PlayerOrganization
    @operation_player_organizations = Operation::PlayerOrganization.accessible_by(current_ability, :read)
    @operation_player_organizations = @operation_player_organizations.search(params[:search]) unless params[:search].blank?
    @operation_player_organizations = @operation_player_organizations.order("#{sort_column} #{sort_direction}") unless sort_column.blank?
    @operation_player_organizations = @operation_player_organizations.paginate(page: params[:page], per_page: 5)
  end

  # GET /operation/player_organizations/1
  # GET /operation/player_organizations/1.json
  def show
    authorize! :read, @operation_player_organization
  end

  # GET /operation/player_organizations/new
  def new
    authorize! :new, PlayerOrganization
    @operation_player_organization = Operation::PlayerOrganization.new
  end

  # GET /operation/player_organizations/1/edit
  def edit
    authorize! :edit, @operation_player_organization
  end

  # POST /operation/player_organizations
  # POST /operation/player_organizations.json
  def create
    @operation_player_organization = Operation::PlayerOrganization.new(operation_player_organization_params)
    @operation_player_organization.operator_id = current_operation_operator.id
    authorize! :create, @operation_player_organization

    respond_to do |format|
      if @operation_player_organization.save
        format.html { redirect_to @operation_player_organization, notice: 'Player organization was successfully created.' }
        format.json { render action: 'show', status: :created, location: @operation_player_organization }
      else
        format.html { render action: 'new' }
        format.json { render json: @operation_player_organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /operation/player_organizations/1
  # PATCH/PUT /operation/player_organizations/1.json
  def update
    authorize! :update, @operation_player_organization
    respond_to do |format|
      if @operation_player_organization.update(operation_player_organization_params)
        format.html { redirect_to @operation_player_organization, notice: 'Player organization was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @operation_player_organization.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_operation_player_organization
      @operation_player_organization = Operation::PlayerOrganization.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def operation_player_organization_params
      params.require(:operation_player_organization).permit(:org_type, :name, :address, :contact_name, :contact_position, :contact_email, :contact_phone)
    end

    # set sort column
    def sort_column
      Operation::PlayerOrganization.column_names.include?(params[:sort]) ? params[:sort] : nil
    end  
      
    # set sort direction
    def sort_direction  
      ['asc', 'desc'].include?(params[:direction]) ?  params[:direction] : "asc"  
    end
end
