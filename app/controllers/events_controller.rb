class EventsController < ApplicationController

  before_action :authenticate_user!


  def index
    @events = Event.includes(:creator)

    respond_to do |format|
      format.html
      format.json { render :json => @events }
      format.xml { render :xml => @events }
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.created_events.build(event_params)

    if @event.save
      ActionCable.server.broadcast('event', @event.as_json(include: :creator))
      UserMailer.with(user: @event.creator).confirmation_email.deliver_later
      # TODO: Edit my mailers to make sendgrid send good emails
      # UserMailer.sendgrid_confirmation_email(@event.creator.email).deliver_later
      redirect_to @event
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      redirect_to @event
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    redirect_to root_path, status: :see_other
  end

  private
  def event_params
    params.require(:event).permit(:name, :date, :location)
  end

  def find_event
    @event = Event.find(params[:id])
  end

  def authorize_user!
    if @event.user_id != current_user.id
      redirect_to @event, alert: "You don't have permission to edit this event."
    end
  end
end
