class Admin::OperatorsController < Admin::AdminController
  before_action :set_admin_operator, only: [:show, :edit, :update, :destroy, :impersonate]
  
  allowed_sort_columns Admin::Operator

  # GET /admin/operators
  # GET /admin/operators.json
  def index
    authorize! :index, Operator
    @admin_operators = Admin::Operator.accessible_by(current_ability, :read)
    @admin_operators = @admin_operators.search(params[:search]) unless params[:search].blank?
    @admin_operators = @admin_operators.order("#{sort_column} #{sort_direction}") unless sort_column.blank?
    @admin_operators = @admin_operators.paginate(page: params[:page], per_page: 5)
  end

  # GET /admin/operators/1
  # GET /admin/operators/1.json
  def show
    authorize! :read, @admin_operator
  end

  # GET /admin/operators/new
  def new
    authorize! :new, Operator
    @admin_operator = Admin::Operator.new
  end

  # GET /admin/operators/1/edit
  def edit
    authorize! :edit, @admin_operator
  end

  # POST /admin/operators
  # POST /admin/operators.json
  def create
    @admin_operator = Admin::Operator.new(admin_operator_params)
    @admin_operator.password = Devise.friendly_token.first(8)
    authorize! :create, @admin_operator

    respond_to do |format|
      if @admin_operator.save
        format.html { redirect_to @admin_operator, notice: 'Operator was successfully created.' }
        format.json { render action: 'show', status: :created, location: @admin_operator }
      else
        format.html { render action: 'new' }
        format.json { render json: @admin_operator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/operators/1
  # PATCH/PUT /admin/operators/1.json
  def update
    authorize! :update, @admin_operator
    send_pass_reset_instructions = false
    if (admin_operator_params.include?(:email) && admin_operator_params[:email] != @admin_operator.email)
      @admin_operator.password = Devise.friendly_token.first(8)
      send_pass_reset_instructions = true
    end

    respond_to do |format|
      if @admin_operator.update(admin_operator_params)
        Admin::Operator.find(params[:id]).send_reset_password_instructions if send_pass_reset_instructions
        format.html { redirect_to @admin_operator, notice: 'Operator was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @admin_operator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/operators/1
  # DELETE /admin/operators/1.json
  def destroy
    authorize! :destroy, @admin_operator
    @admin_operator.destroy
    respond_to do |format|
      format.html { redirect_to admin_operators_url }
      format.json { head :no_content }
    end
  end

  def impersonate
    authorize! :impersonate, @admin_operator
    sign_in(@admin_operator, :bypass => true)
    redirect_to operation_root_url, :notice => t(:logged_in_as_operator, operator_email: @admin_operator.email)
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_operator
      @admin_operator = Admin::Operator.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_operator_params
      params.require(:admin_operator).permit(:name, :email, :country, :reg_code_prefix, :disabled)
    end

end
