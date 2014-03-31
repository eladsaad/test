class Api::V1::InteractiveVideosController < Api::BaseApiController

  def index
    authorize! :index, InteractiveVideo
    render text: 'inside index action'
  end

  
end
