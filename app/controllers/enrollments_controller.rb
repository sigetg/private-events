class EnrollmentsController < ApplicationController

  def index
    if params[:event_id]
      @enrollments = Event.find(params[:event_id]).enrollments
    else
      @enrollments = Enrollment.all
    end
  end

  def create
    @event = Event.find(enrollment_params[:event_id])
    @enrollment = @event.enrollments.build(user: current_user)

    if @enrollment.save
      flash[:success] = 'You have successfully joined the event!'
    else
      flash[:error] = 'Error joining the event.'
    end
    redirect_to event_path(enrollment_params[:event_id])
  end

  private
  # def enrollment_params
  #   params.permit(:event_id, :user_id)
  # end
end
