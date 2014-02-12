class Admin::ImagesController < Admin::AdminController
  before_action :set_admin_image, only: [:show, :edit, :update, :destroy]

  allowed_sort_columns Admin::Image

  set_pagination_headers :admin_images, only: [:index]

  # GET /admin/images
  # GET /admin/images.json
  def index
    authorize! :index, Image
    @admin_images = Admin::Image.accessible_by(current_ability, :read)
    @admin_images = @admin_images.search(params[:search]) unless params[:search].blank?
    @admin_images = @admin_images.order("#{sort_column} #{sort_direction}") unless sort_column.blank?
    @admin_images = @admin_images.paginate(page: params[:page], per_page: params[:per_page] || 100)
  end

  # GET /admin/images/1
  # GET /admin/images/1.json
  def show
    authorize! :read, @admin_image
  end

  # GET /admin/images/new
  def new
    @admin_image = Admin::Image.new
    authorize! :new, @admin_image
  end

  # GET /admin/images/1/edit
  def edit
    authorize! :edit, @admin_image
  end

  # POST /admin/images
  # POST /admin/images.json
  def create
    @admin_image = Admin::Image.new(admin_image_params)
    authorize! :create, @admin_image

    respond_to do |format|
      if @admin_image.save
        format.html { redirect_to @admin_image, notice: 'Image was successfully created.' }
        format.json { render action: 'show', status: :created, location: @admin_image }
      else
        format.html { render action: 'new' }
        format.json { render json: @admin_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/images/1
  # PATCH/PUT /admin/images/1.json
  def update
    authorize! :update, @admin_image

    respond_to do |format|
      if @admin_image.update(admin_image_params)
        format.html { redirect_to @admin_image, notice: 'Image was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @admin_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/images/1
  # DELETE /admin/images/1.json
  def destroy
    authorize! :destroy, @admin_image
    @admin_image.destroy
    respond_to do |format|
      format.html { redirect_to admin_images_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_image
      @admin_image = Admin::Image.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_image_params
      params.require(:admin_image).permit(:url, :thumbnail_url, :name, :description, :format)
    end
end
