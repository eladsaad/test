class StaticPagesController < ApplicationController

  def programs
    #TODO: a page listing all available programs and links to their URLs
    raise ActionController::RoutingError.new('Not Found')
  end

  # GET /players/dashboard
  def welcome
    #TODO: implement
    if player_signed_in?
      redirect_to interactive_videos_path
    end
  end

  def about

    #flash[:points] = ["You just did something<br>and won extra" , '2000']

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

end
