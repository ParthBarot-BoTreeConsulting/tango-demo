class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :location_name
      t.float :longitude
      t.float :latitude
      t.integer :event_id

      t.timestamps
    end
  end
end
