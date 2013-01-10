class EventsController < ApplicationController

  def index

  end

  def create
    location = Location.new(params[:location])
    event = Event.new(params[:event])
    event.event_time = Time.parse(params[:event][:event_time])
    event.location = location
    event.user = current_user
    if event.save
      flash[:notice] = "Event successfully created."
    else
      flash[:alert] = "Error while creation event :: #{event.errors.messages}"
    end
    redirect_to '/events/index'
  end

  def new
    @location = Location.new
    @event = Event.new(location: @location)
  end

  def search
    keyword = params[:search_keyword]
    @events = Event.where('event_name like %keyword%')
  end

  def list_user_events
    @events = current_user.events if user_signed_in?
  end

end
