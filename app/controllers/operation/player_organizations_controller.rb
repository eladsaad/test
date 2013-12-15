class Operation::PlayerOrganizationsController < Operation::OperationController
  before_action :set_operation_player_organization, only: [:show, :edit, :update, :destroy]

  # GET /operation/player_organizations
  # GET /operation/player_organizations.json
  def index
    authorize! :index, PlayerOrganization
    @operation_player_organizations = Operation::PlayerOrganization.accessible_by(current_ability, :read)
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

  # DELETE /operation/player_organizations/1
  # DELETE /operation/player_organizations/1.json
  def destroy
    authorize! :destroy, @operation_player_organization
    @operation_player_organization.destroy
    respond_to do |format|
      format.html { redirect_to operation_player_organizations_url }
      format.json { head :no_content }
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
end
