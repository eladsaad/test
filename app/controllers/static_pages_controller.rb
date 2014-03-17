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
    #TODO: implement

    flash[:points] = ["You just did something<br>and won extra" , '2000']

    #respond_to do |format|
    #  format.html { redirect_to '/about', notice: '' }
    #  format.js   {}
    #end
  end

  def facebook_canvas_page
    render :layout => false
    # TODO: implement
  end

end
