class StatusObserver < ActiveRecord::Observer
  def after_create(status)
    Status.last.update_attribute(:status, "Hey buddy")
  end
end
