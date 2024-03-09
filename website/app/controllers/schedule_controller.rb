class ScheduleController < ApplicationController
    def index
    end
  
    def events
      @events = Event.all # Fetch events from your database
      render json: @events.map { |event| { id: event.id, title: event.title, start: event.start_time, end: event.end_time } }
    end
  end