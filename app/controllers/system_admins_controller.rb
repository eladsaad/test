class SystemAdminsController < ApplicationController
  before_action :set_system_admin, only: [:show, :edit, :update, :destroy]

  # GET /system_admins
  # GET /system_admins.json
  def index
    @system_admins = SystemAdmin.all
  end

  # GET /system_admins/1
  # GET /system_admins/1.json
  def show
  end

  # GET /system_admins/new
  def new
    @system_admin = SystemAdmin.new
  end

  # GET /system_admins/1/edit
  def edit
  end

  # POST /system_admins
  # POST /system_admins.json
  def create
    @system_admin = SystemAdmin.new(system_admin_params)

    respond_to do |format|
      if @system_admin.save
        format.html { redirect_to @system_admin, notice: 'System admin was successfully created.' }
        format.json { render action: 'show', status: :created, location: @system_admin }
      else
        format.html { render action: 'new' }
        format.json { render json: @system_admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /system_admins/1
  # PATCH/PUT /system_admins/1.json
  def update
    respond_to do |format|
      if @system_admin.update(system_admin_params)
        format.html { redirect_to @system_admin, notice: 'System admin was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @system_admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /system_admins/1
  # DELETE /system_admins/1.json
  def destroy
    @system_admin.destroy
    respond_to do |format|
      format.html { redirect_to system_admins_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_system_admin
      @system_admin = SystemAdmin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def system_admin_params
      params.require(:system_admin).permit(:email, :first_name, :last_name)
    end
end
