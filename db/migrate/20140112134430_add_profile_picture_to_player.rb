class AddProfilePictureToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :profile_picture, :string
  end
end
