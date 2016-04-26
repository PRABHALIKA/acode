class ActivitiesController < ApplicationController
  def timeline
    fids = current_user.relations.where(subject: Constants::Subject::MAKE).collect(&:friend_id)
    current_user_id = current_user.id
    # statuses = Status.search do
    #   with(:user_id, 1)
    #   with(:subject, Constants::Subject::MAKE)
    # end
    # @statuses = statuses.results
    @statuses = Status.where(user_id: fids << current_user_id, subject: Constants::Subject::MAKE)
    relations = Relation.search do
      if fids.present?
        with(:friend_id, fids)
        with(:user_id, current_user_id)
        with(:subject, Constants::Subject::MAKE)
      end
    end
    @relations = relations.results
    @activities = (@statuses + @relations).sort_by(&:created_at).reverse
  end
end
