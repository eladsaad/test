class StaticPagesController < ApplicationController

  def programs
    #TODO: a page listing all available programs and links to their URLs
    raise ActionController::RoutingError.new('Not Found')
  end

  # GET /players/dashboard
  def welcome
    #TODO: implement
    @online_program = current_online_program
  end

  def about
    #TODO: implement
  end

end
