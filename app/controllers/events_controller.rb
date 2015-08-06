class EventsController < ApplicationController
  #skip_before_action :authenticate, only: :index

  def index
    render json: Event.all #current_user.events
  end

  def show
    render json: Event.find(params[:id])
  end

  def create
    event = Event.create(event_params)
    event.created_by = current_user
    if event.save
      render json: event
    else
      render json: event.errors, status: :unprocessable_entity
    end
  end

  def update
    event = Event.find(params[:id])
    if event.update(event_params)
      event.save
      render json: event
    else
      render json: event.errors, status: :unprocessable_entity
    end
  end

  def destroy
    event = Event.find(params[:id])
    event.destroy!
    head :ok
  end

  private
  def event_params
    params.require(:event).permit(:description, :date, :time, :location, :address_line1, :city, :state, :zip)
  end
end
