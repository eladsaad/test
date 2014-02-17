class CampaignsController < BaseController

  layout false

  before_action :set_campaign, only: [:click]

  def click
    @campaign = Campaign.find(params[:id])
    authorize! :click, @campaign
    @campaign.clicks += 1
    @campaign.save

    respond_to do |format|
      format.html { redirect_to @campaign.landing_page }
      format.js   { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_campaign
      @campaign = Campaign.find(params[:id])
    end

end
