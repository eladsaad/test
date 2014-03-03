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

    #respond_to do |format|
    #  format.html { redirect_to '/about', notice: '' }
    #  format.js   {}
    #end
  end

end
