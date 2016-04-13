class StatusesController < ApplicationController
  def show
    @status = Status.find(params[:id])
  end
  
  def create
    @status = Status.new(status_params)
    if @status.valid? && @status.save
      update_user_id(@status)
      redirect_to timeline_activities_path, notice: 'Status Posted!'
    else
      redirect_to 'new', alert: "Couldn't post status"
    end
  end

  protected
    def status_params
      params.require(:status).permit(:status, :statachment, :user_id)
    end
end
