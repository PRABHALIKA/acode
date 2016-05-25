class NotificationsController < ApplicationController
  def index
    @notifications = Notification.where(recipient_id: current_user.id)
    @notifications.each { |n| n.update_attribute(:seen, true) }   
  end
end
