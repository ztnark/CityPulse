class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string   :title
      t.string   :venue_name
      t.float    :latitude
      t.float    :longitude
      t.datetime :start_time
      t.datetime :stop_time
      t.string   :at_time
      t.string   :eventful_id
      t.string   :thumb
      t.string   :url
      t.string   :city_name
      t.string   :venue_address
      t.string   :region_abbr
      t.string   :postal_code

      t.timestamps
    end
  end
end