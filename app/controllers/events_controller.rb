class EventsController < ApplicationController
  before_action :require_login
  before_action :find_event, only: [:edit, :update, :destroy]

  def new
    @event = Event.new
  end

  def destroy
    @event.deleted = true
    redirect_to calendar_path, notice: "Event deleted successfully"
  end

  def create
    @event = Current.user.events.build(event_params)
    @event.deleted = false

    if @event.save
      respond_to do |format|
        format.html { redirect_to calendar_path, notice: "Event created!" }
        format.js # This line will execute create.js.erb template
      end
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to calendar_path, notice: "Event updated!"
    else
      render :edit
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :start_time, :end_time, :priority)
  end

  def require_login
    unless session[:user_id] && User.exists?(session[:user_id])
      flash[:alert] = 'Must sign in to use this feature.'
      redirect_to sign_in_path
    end
  end

  def find_event
    @event = Current.user.events.find(params[:id])
  end
end