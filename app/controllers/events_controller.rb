class EventsController < ApplicationController

  include Utils::GeoLocationUtility

  DATE_TIME_FORMAT_WITH_TIME_ZONE = '%Y-%m-%d %H:%M %Z'

  def index

  end

  def create
    location = Location.new(params[:location])
    event = Event.new(params[:event])
    #event.event_time = DateTime.strptime(params[:event][:event_time], DATE_TIME_FORMAT_WITH_TIME_ZONE)
    #event.event_time_zone = event.event_time
    event.location = location
    event.user = current_user
    if event.save
      flash[:notice] = "Event successfully created."
    else
      flash[:alert] = "Event creation failed :: #{event.errors.messages[:event_name].first}"
    end
    redirect_to '/events/index'
  end

  def new
    @location = Location.new
    @event = Event.new(location: @location)
  end

  def search
    keyword = params[:search_keyword]
    is_using_distance = params[:is_distance_range] == 'true'
    if is_using_distance
      latitude = params[:search_latitude]
      longitude = params[:search_longitude]
      miles_range = params[:distance_range].to_i
      @current_location = params[:current_location]
      event_ids = find_ordinates_in_range latitude, longitude, miles_range
      @events = Event.where('id IN (?)', event_ids)
    else
      @events = Event.joins(:location).where("event_name ILIKE ? OR locations.location_name ILIKE ?", "%#{keyword}%", "%#{keyword}%")
    end
    respond_to do |format|
      format.js
      format.html
    end
  end

  def list_user_events
    @events = current_user.events if user_signed_in?
  end

  def delete
    @id = params[:id]
    Event.delete(@id.to_i) if @id.present?
    respond_to do |format|
      format.js { render "delete" }
    end
  end

end
