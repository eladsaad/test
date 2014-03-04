class AddTermsAcceptedToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :tos_accepted, :boolean, default: false
  end
end
