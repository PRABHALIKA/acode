class SwitchUserAccountsController < ApplicationController
  def switch
    session[:original_user] = current_user.id
    if session[:original_user]
      $original_user = User.where(id: session[:original_user].to_i).first unless session[:original_user].blank?
    end
    if params[:id]
      $non_original_user = User.where(id: params[:id].to_i).first
    end
    sign_out $original_user
    sign_in $non_original_user
    redirect_to current_user
  end

  def switch_back
    if $original_user && $non_original_user
      sign_out $non_original_user
      sign_in $original_user
      $non_original_user = nil
      $original_user = nil
      redirect_to current_user
    else
      redirect_to current_user, notice: "Could not switch back to original user"
    end
  end
end
