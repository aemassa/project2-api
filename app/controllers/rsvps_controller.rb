class RsvpsController < ApplicationController
  #skip_before_action :authenticate, only: :index

  def index
    render json: Rsvp.all
    #render json: current_user.events
  end

  def show
    render json: Rsvp.find(params[:id])
  end

  def create
    rsvp = current_user.rsvps.create(rsvp_params)
    if rsvp.save
      render json: rsvp
    else
      render json: rsvp.errors, status: :unprocessable_entity
    end
  end

  def update
    rsvp = Rsvp.find(params[:id])
    if rsvp.update(rsvp_params)
      rsvp.save
      render json: rsvp
    else
      render json: rsvp.errors, status: :unprocessable_entity
    end
  end

  def destroy
    rsvp = Rsvp.find(params[:id])
    rsvp.destroy!
    head :ok
  end

  private
  def rsvp_params
    params.require(:rsvp).permit(:confirmed, :item, :user_id, :event_id)
  end
end
