class Location < ActiveRecord::Base
  attr_accessible :event_id, :latitude, :location_name, :longitude

  belongs_to :event
end
