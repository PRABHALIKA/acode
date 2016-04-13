class RelationsController < ApplicationController
  def create
    if params[:friend_id]
      if Relation.where(user_id: current_user.id, friend_id: params[:friend_id]).present?
        redirect_to user_path(params[:friend_id]), notice: "Already friends"
      elsif current_user.id == params[:friend_id]
        redirect_to user_path(params[:friend_id]), notice: "Invalid Request"
      else
        @relation = current_user.relations.new(friend_id: params[:friend_id], status: Constants::Status::MAKE)
        if @relation.save
          friend = User.find(params[:friend_id])
          friend.relations.create!(friend_id: current_user.id, status: Constants::Status::MAKE)
          redirect_to user_path(params[:friend_id]), notice: "Added as friend"
        else
          redirect_to user_path(params[:friend_id]), notice: "Could not add as friend"
        end
      end
    else
      redirect_to current_user, notice: "Invalid Request"
    end
  end

  def destroy
    binding.pry
    if params[:id]
      relation = Relation.where(id: params[:id]).first
      if relation.present?
        relation.update_attribute(:status, Constants::Status::BREAK)
        redirect_to root_path, notice: "Successful"
      else
        redirect_to root_path, notice: "Could not delete. Please try later"
      end
    else
      redirect_to current_user, notice: "Invalid Request"
    end
  end
end
