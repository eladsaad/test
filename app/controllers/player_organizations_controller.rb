class PlayerOrganizationsController < ApplicationController
  before_action :set_player_organization, only: [:show, :edit, :update, :destroy]

  # GET /player_organizations
  # GET /player_organizations.json
  def index
    @player_organizations = PlayerOrganization.all
  end

  # GET /player_organizations/1
  # GET /player_organizations/1.json
  def show
  end

  # GET /player_organizations/new
  def new
    @player_organization = PlayerOrganization.new
  end

  # GET /player_organizations/1/edit
  def edit
  end

  # POST /player_organizations
  # POST /player_organizations.json
  def create
    @player_organization = PlayerOrganization.new(player_organization_params)

    respond_to do |format|
      if @player_organization.save
        format.html { redirect_to @player_organization, notice: 'Player organization was successfully created.' }
        format.json { render action: 'show', status: :created, location: @player_organization }
      else
        format.html { render action: 'new' }
        format.json { render json: @player_organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /player_organizations/1
  # PATCH/PUT /player_organizations/1.json
  def update
    respond_to do |format|
      if @player_organization.update(player_organization_params)
        format.html { redirect_to @player_organization, notice: 'Player organization was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @player_organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /player_organizations/1
  # DELETE /player_organizations/1.json
  def destroy
    @player_organization.destroy
    respond_to do |format|
      format.html { redirect_to player_organizations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player_organization
      @player_organization = PlayerOrganization.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_organization_params
      params.require(:player_organization).permit(:org_type, :name, :address, :contact_name, :contact_position, :contact_email, :contact_phone)
    end
end
