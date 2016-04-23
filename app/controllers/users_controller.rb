class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    unless @user == current_user
      @relation = Relation.where(user_id: current_user.id, friend_id: @user.id, subject: Constants::Subject::MAKE).first
    end
  end

  def index
    @users = User.all
  end
end
