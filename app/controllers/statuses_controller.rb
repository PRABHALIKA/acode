class StatusesController < ApplicationController
  def show
    @status = Status.find(params[:id])
  end
  
  def create
    @status = Status.new(status_params)
    if @status.valid? && @status.save
      if params[:Draft]
        update_user_id(@status, Constants::Subject::DRAFT)
        redirect_to timeline_activities_path, notice: 'Status drafted. Check in your drafts'
      else
        update_user_id(@status)
        redirect_to timeline_activities_path, notice: 'Status Posted!'
      end
    else
      redirect_to 'new', alert: "Couldn't post status"
    end
  end

  def destroy
    @status = Status.where(id: params[:id]).first
    if @status.present?
      make_subject(@status, Constants::Subject::BREAK)
      respond_to do |format|
        format.js { render layout: false }
      end
    end
  end

  protected
    def status_params
      params.require(:status).permit(:status, :statachment, :user_id, :subject)
    end
end
