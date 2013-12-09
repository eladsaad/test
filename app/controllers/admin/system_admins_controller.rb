class Admin::SystemAdminsController < Admin::AdminController
  before_action :set_admin_system_admin, only: [:show, :edit, :update, :destroy]

  # GET /admin/system_admins
  # GET /admin/system_admins.json
  def index
    @admin_system_admins = Admin::SystemAdmin.all
  end

  # GET /admin/system_admins/1
  # GET /admin/system_admins/1.json
  def show
  end

  # GET /admin/system_admins/new
  def new
    @admin_system_admin = Admin::SystemAdmin.new
  end

  # GET /admin/system_admins/1/edit
  def edit
  end

  # POST /admin/system_admins
  # POST /admin/system_admins.json
  def create
    @admin_system_admin = Admin::SystemAdmin.new(admin_system_admin_params)

    respond_to do |format|
      if @admin_system_admin.save
        format.html { redirect_to @admin_system_admin, notice: 'System admin was successfully created.' }
        format.json { render action: 'show', status: :created, location: @admin_system_admin }
      else
        format.html { render action: 'new' }
        format.json { render json: @admin_system_admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/system_admins/1
  # PATCH/PUT /admin/system_admins/1.json
  def update
    respond_to do |format|
      if @admin_system_admin.update(admin_system_admin_params)
        format.html { redirect_to @admin_system_admin, notice: 'System admin was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @admin_system_admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/system_admins/1
  # DELETE /admin/system_admins/1.json
  def destroy
    @admin_system_admin.destroy
    respond_to do |format|
      format.html { redirect_to admin_system_admins_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_system_admin
      @admin_system_admin = Admin::SystemAdmin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_system_admin_params
      params.require(:admin_system_admin).permit(:email, :first_name, :last_name)
    end
end
