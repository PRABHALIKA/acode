module ApplicationHelper
  def get_resource_count(resource)
    count = resource.classify.constantize.where(recipient_id: current_user.id, seen: false).count
    count = false if count == 0
    count
  end
end
