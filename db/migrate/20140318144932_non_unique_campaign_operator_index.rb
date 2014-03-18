class NonUniqueCampaignOperatorIndex < ActiveRecord::Migration
  def change
  	remove_index :campaign_operator_programs, name: 'index_operator_online_program'
  	add_index :campaign_operator_programs, [:operator_id, :online_program_id], name: 'index_operator_online_program'
  end
end
