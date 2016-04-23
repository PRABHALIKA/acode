class RelationsController < ApplicationController
  def create
    if params[:friend_id]
      @relation = Relation.where(user_id: current_user.id, friend_id: params[:friend_id], subject: Constants::Subject::BREAK).first
      if @relation.present?
        @relation.update_attribute(:subject, Constants::Subject::MAKE)
      else
        @relation = Relation.new(user_id: current_user.id, friend_id: params[:friend_id], subject: Constants::Subject::MAKE)
        @relation.save
      end
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy
    if params[:id]
      relation = Relation.where(id: params[:id]).first
      if relation.present?
        make_subject(relation, Constants::Subject::BREAK)
        binding.pry
        redirect_to @user, notice: t('relations.successful')
      else
        redirect_to root_path, alert: t('shared.false_success')
      end
    else
      redirect_to current_user, alert: t('shared.invalid_request')
    end
  end
end
