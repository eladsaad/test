class Operation::OperatorMobileStationsController < Operation::OperationController
  before_action :set_operation_operator_mobile_station, only: [:show, :edit, :update, :destroy]
  
  allowed_sort_columns Operation::OperatorMobileStation

  # GET /operation/operator_mobile_stations
  # GET /operation/operator_mobile_stations.json
  def index
    authorize! :index, OperatorMobileStation
    @operation_operator_mobile_stations = Operation::OperatorMobileStation.accessible_by(current_ability, :read)
    @operation_operator_mobile_stations = @operation_operator_mobile_stations.search(params[:search]) unless params[:search].blank?
    @operation_operator_mobile_stations = @operation_operator_mobile_stations.order("#{sort_column} #{sort_direction}") unless sort_column.blank?
    @operation_operator_mobile_stations = @operation_operator_mobile_stations.paginate(page: params[:page], per_page: 100)
  end

  # GET /operation/operator_mobile_stations/1
  # GET /operation/operator_mobile_stations/1.json
  def show
    authorize! :read, @operation_operator_mobile_station
  end

  # GET /operation/operator_mobile_stations/new
  def new
    authorize! :new, OperatorMobileStation
    @operation_operator_mobile_station = Operation::OperatorMobileStation.new
  end

  # GET /operation/operator_mobile_stations/1/edit
  def edit
    authorize! :edit, @operation_operator_mobile_station
  end

  # POST /operation/operator_mobile_stations
  # POST /operation/operator_mobile_stations.json
  def create
    @operation_operator_mobile_station = Operation::OperatorMobileStation.new(operation_operator_mobile_station_params)
    @operation_operator_mobile_station.operator_id = current_operation_operator.id
    authorize! :create, @operation_operator_mobile_station

    respond_to do |format|
      if @operation_operator_mobile_station.save
        format.html { redirect_to @operation_operator_mobile_station, notice: 'Operator mobile station was successfully created.' }
        format.json { render action: 'show', status: :created, location: @operation_operator_mobile_station }
      else
        format.html { render action: 'new' }
        format.json { render json: @operation_operator_mobile_station.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /operation/operator_mobile_stations/1
  # PATCH/PUT /operation/operator_mobile_stations/1.json
  def update
    authorize! :update, @operation_operator_mobile_station
    respond_to do |format|
      if @operation_operator_mobile_station.update(operation_operator_mobile_station_params)
        format.html { redirect_to @operation_operator_mobile_station, notice: 'Operator mobile station was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @operation_operator_mobile_station.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /operation/operator_mobile_stations/1
  # DELETE /operation/operator_mobile_stations/1.json
  def destroy
    authorize! :destroy, @operation_operator_mobile_station
    @operation_operator_mobile_station.destroy
    respond_to do |format|
      format.html { redirect_to operation_operator_mobile_stations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_operation_operator_mobile_station
      @operation_operator_mobile_station = Operation::OperatorMobileStation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def operation_operator_mobile_station_params
      params.require(:operation_operator_mobile_station).permit(:code)
    end

end
