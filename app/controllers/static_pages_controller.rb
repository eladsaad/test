class StaticPagesController < ApplicationController

  skip_before_filter :redirect_mobile_devices, only: :mobile


  # GET /players/dashboard
  def welcome
    if player_signed_in?
      redirect_to interactive_videos_path
    end
  end

  def about
    @active_page = 'about'

    respond_to do |format|
      format.html { render 'text_content' }
      format.js   { render 'text_content' }
    end
  end

  def terms
    @active_page = 'terms'

    respond_to do |format|
      format.html { render 'text_content' }
      format.js   { render 'text_content' }
    end
  end

  def terms_modal
  end

  def confirm_reg
  end

  def mobile
    render :layout => false
  end

end
