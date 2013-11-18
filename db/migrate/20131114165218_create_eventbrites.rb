class CreateEventbrites < ActiveRecord::Migration
  def change
    create_table :eventbrites do |t|
      t.string   :title
      t.string   :venue
      t.float    :latitude
      t.float    :longitude
      t.datetime :start_date
      t.datetime :end_date
      t.string   :at_time
      t.string   :eventbrite_id
      t.string   :thumb
      t.string   :url
      t.string   :city
      t.string   :address
      t.string   :state
      t.string   :postal_code

      t.timestamps
    end
  end
end
