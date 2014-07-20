class Admin::CampaignsController < Admin::AdminController
  before_action :set_admin_campaign, only: [:show, :edit, :update, :destroy]

  allowed_sort_columns Admin::Campaign 

  set_pagination_headers :admin_campaigns, only: [:index]


  # GET /admin/campaigns
  # GET /admin/campaigns.json
  def index
    authorize! :index, Campaign
    @admin_campaigns = Admin::Campaign.accessible_by(current_ability, :read)
    @admin_campaigns = @admin_campaigns.search(params[:search]) unless params[:search].blank?
    @admin_campaigns = @admin_campaigns.order("#{sort_column} #{sort_direction}") unless sort_column.blank?
    @admin_campaigns = @admin_campaigns.paginate(page: params[:page], per_page: params[:per_page] || 100)
  end

  # GET /admin/campaigns/1
  # GET /admin/campaigns/1.json
  def show
    authorize! :read, @admin_campaign
  end

  # GET /admin/campaigns/new
  def new
    @admin_campaign = Admin::Campaign.new
    authorize! :new, @admin_campaign
  end

  # GET /admin/campaigns/1/edit
  def edit
    authorize! :edit, @admin_campaign
  end

  # POST /admin/campaigns
  # POST /admin/campaigns.json
  def create
    @admin_campaign = Admin::Campaign.new(admin_campaign_params)
    authorize! :create, @admin_campaign

    respond_to do |format|
      if @admin_campaign.save
        format.html { redirect_to @admin_campaign, notice: 'Campaign was successfully created.' }
        format.json { render action: 'show', status: :created, location: @admin_campaign }
      else
        format.html { render action: 'new' }
        format.json { render json: @admin_campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/campaigns/1
  # PATCH/PUT /admin/campaigns/1.json
  def update
    authorize! :update, @admin_campaign
    respond_to do |format|
      if @admin_campaign.update(admin_campaign_params)
        format.html { redirect_to @admin_campaign, notice: 'Campaign was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @admin_campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/campaigns/1
  # DELETE /admin/campaigns/1.json
  def destroy
    authorize! :destroy, @admin_campaign
    @admin_campaign.destroy
    respond_to do |format|
      format.html { redirect_to admin_campaigns_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_campaign
      @admin_campaign = Admin::Campaign.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_campaign_params
      params.require(:admin_campaign).permit(
        :name,
        :max_views,
        :trophy_name,
        :landing_page,
        :banner_image,
        :website_banner_html_01,
        :website_banner_html_02,
        :website_banner_html_03,
        :website_banner_html_04,
        :website_banner_html_05,
        :website_banner_html_06,
        :website_banner_html_07,
        :website_banner_html_08,
        :website_banner_html_09,
        :website_banner_html_10,
        :campaign_operator_programs_attributes => [
          :operator_id,
          :online_program_id,
          :id,
          :_destroy
        ]
      )
    end
end
