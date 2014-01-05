class PlayerGroupAssociationsController < BaseController

  # GET /player_groups/new
  def new
    authorize! :new, PlayerGroupAssociation
    @player_group_association = PlayerGroupAssociation.new
  end

  # POST /player_groups
  # POST /player_groups.json
  def create
    @player_group_association = PlayerGroupAssociation.new(player_id: current_player.id)

    given_reg_code = params.require(:reg_code)
    group = PlayerGroup.find_by_reg_code(given_reg_code)
    
    if group.nil?
      @player_group_association.errors.add(:base, 'Wrong registration code given')
    else
      @player_group_association.player_group_id = group.id
    end

    authorize! :create, @player_group_association

    respond_to do |format|
      if @player_group_association.errors.empty? && @player_group_association.save
        format.html { redirect_to root_url, notice: 'Joined group' }
        format.json { head :no_content }
      else
        format.html { render action: 'new' }
        format.json { render json: @player_group_association.errors, status: :unprocessable_entity }
      end
    end

  end

end
