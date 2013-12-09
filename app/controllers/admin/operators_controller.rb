class Admin::OperatorsController < Admin::AdminController
  before_action :set_admin_operator, only: [:show, :edit, :update, :destroy]

  # GET /admin/operators
  # GET /admin/operators.json
  def index
    @admin_operators = Admin::Operator.all
  end

  # GET /admin/operators/1
  # GET /admin/operators/1.json
  def show
  end

  # GET /admin/operators/new
  def new
    @admin_operator = Admin::Operator.new
  end

  # GET /admin/operators/1/edit
  def edit
  end

  # POST /admin/operators
  # POST /admin/operators.json
  def create
    @admin_operator = Admin::Operator.new(admin_operator_params)

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
    respond_to do |format|
      if @admin_operator.update(admin_operator_params)
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
    @admin_operator.destroy
    respond_to do |format|
      format.html { redirect_to admin_operators_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_operator
      @admin_operator = Admin::Operator.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_operator_params
      params.require(:admin_operator).permit(:name, :email, :country, :reg_code_prefix)
    end
end
