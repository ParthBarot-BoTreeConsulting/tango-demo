class Event < ActiveRecord::Base
  attr_accessible :event_name, :event_time, :user_id, :location

  belongs_to :user

  has_one :location

  validates_uniqueness_of :event_name,
                          :case_sensitive => false,
                          :allow_blank => false
end
