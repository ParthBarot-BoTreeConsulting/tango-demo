class Event < ActiveRecord::Base
  attr_accessible :event_name, :event_time, :user_id, :location

  belongs_to :user

  has_one :location

  validates_presence_of :event_name, :message => 'Event name can not be blank.'

  validates_uniqueness_of :event_name, :case_sensitive => false, :allow_blank => false,
                          :message => 'Name not available, please choose another name for event.'
end
