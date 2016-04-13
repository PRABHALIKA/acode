class ActivitiesController < ApplicationController
  def timeline
    fids = current_user.friends.collect(&:id)
    current_user_id = current_user.id
    statuses = Status.search do
      with(:user_id, (fids << current_user_id))
    end
    @statuses = statuses.results
    relations = Relation.search do
      if fids.present?
        with(:friend_id, fids)
        with(:user_id, current_user_id)
        with(:status, Constants::Status::MAKE)
      end
    end
    @relations = relations.results
    @activities = (@statuses + @relations).sort_by(&:created_at).reverse
  end
end
