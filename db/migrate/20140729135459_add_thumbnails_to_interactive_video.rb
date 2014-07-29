class AddThumbnailsToInteractiveVideo < ActiveRecord::Migration
  def change
    add_column :interactive_videos, :thumbnail_url, :text
    add_column :interactive_videos, :thumbnail_disabled_url, :text
  end
end
