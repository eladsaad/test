class AddContentMobileToInteractiveVideos < ActiveRecord::Migration
  def change
    add_column :interactive_videos, :content_mobile, :text
  end
end
