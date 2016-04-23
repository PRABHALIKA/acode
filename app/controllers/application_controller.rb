class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :authenticate_user!
  before_action :configure_devise_permitted_parameters, if: :devise_controller? 
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource_or_scope)
    root_path
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  def update_user_id(status, subject = Constants::Subject::MAKE)
    if status && status.update_attribute(:user_id, current_user.id)
      make_subject(status, subject)
    end
  end

  def make_subject(activity, subject)
    if activity
      activity.update_attribute(:subject, subject)
    end
  end

  protected
    def configure_devise_permitted_parameters
      registration_params = [:first_name, :last_name, :dob, :gender, :about_me, :email, :password, :password_confirmation, :avatar]
      #devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name) }
      if params[:action] == 'update'
        devise_parameter_sanitizer.for(:account_update) { 
          |u| u.permit(registration_params << :current_password, :avatar)
        }
      elsif params[:action] == 'create'
        devise_parameter_sanitizer.for(:sign_up) { 
          |u| u.permit(registration_params) 
        }
      end
    end
end
