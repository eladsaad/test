class Admin::NotificationsController < Admin::AdminController
  before_action :set_admin_notification, only: [:show, :edit, :update, :destroy]

  allowed_sort_columns Admin::Operator

  set_pagination_headers :admin_notifications, only: [:index]

  # GET /admin/notifications
  # GET /admin/notifications.json
  def index
    authorize! :index, Notification
    @admin_notifications = Admin::Notification.accessible_by(current_ability, :read)
    @admin_notifications = @admin_notifications.search(params[:search]) unless params[:search].blank?
    @admin_notifications = @admin_notifications.order("#{sort_column} #{sort_direction}") unless sort_column.blank?
    @admin_notifications = @admin_notifications.paginate(page: params[:page], per_page: 5)
  end

  # GET /admin/notifications/1
  # GET /admin/notifications/1.json
  def show
    authorize! :read, @admin_notification
  end

  # GET /admin/notifications/new
  def new
    authorize! :new, Notification
    @admin_notification = Admin::Notification.new

    @language_codes = Admin::LanguageCode.all
  end

  # GET /admin/notifications/1/edit
  def edit
    authorize! :edit, @admin_notification

    @language_codes = Admin::LanguageCode.all
  end

  # POST /admin/notifications
  # POST /admin/notifications.json
  def create
    @admin_notification = Admin::Notification.new(admin_notification_params)
    authorize! :create, @admin_notification

    respond_to do |format|
      if @admin_notification.save
        format.html { redirect_to @admin_notification, notice: 'Notification was successfully created.' }
        format.json { render action: 'show', status: :created, location: @admin_notification }
      else
        format.html { render action: 'new' }
        format.json { render json: @admin_notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/notifications/1
  # PATCH/PUT /admin/notifications/1.json
  def update
    authorize! :update, @admin_notification

    respond_to do |format|
      if @admin_notification.update(admin_notification_params)
        format.html { redirect_to @admin_notification, notice: 'Notification was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @admin_notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/notifications/1
  # DELETE /admin/notifications/1.json
  def destroy
    authorize! :destroy, @admin_notification

    @admin_notification.destroy
    respond_to do |format|
      format.html { redirect_to admin_notifications_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_notification
      @admin_notification = Admin::Notification.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_notification_params
      params.require(:admin_notification).permit(:name, :language_code_id, :title, :email_content, :facebook_content)
    end
end
