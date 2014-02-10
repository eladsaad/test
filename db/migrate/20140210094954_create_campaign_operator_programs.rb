class CreateCampaignOperatorPrograms < ActiveRecord::Migration
  def change
    create_table :campaign_operator_programs do |t|
      t.integer :campaign_id
      t.integer :operator_id
      t.integer :online_program_id

      t.timestamps
    end

    add_index :campaign_operator_programs, :campaign_id
    add_index :campaign_operator_programs, [:operator_id, :online_program_id], name: 'index_operator_online_program', unique: true
  end
end
