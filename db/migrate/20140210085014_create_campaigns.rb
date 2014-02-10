class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :name
      t.integer :max_views
      t.integer :views, default: 0
      t.integer :clicks, default: 0
      t.string :trophy_name
      t.string :landing_page, limit: 1000
      t.text :banner_html_01
      t.text :banner_html_02
      t.text :banner_html_03
      t.text :banner_html_04
      t.text :banner_html_05
      t.text :banner_html_06
      t.text :banner_html_07
      t.text :banner_html_08
      t.text :banner_html_09
      t.text :banner_html_10

      t.timestamps
    end

    add_index :campaigns, :name
  end
end
