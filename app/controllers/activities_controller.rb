class ActivitiesController < ApplicationController
  def timeline
    fids = current_user.relations.where(subject: Constants::Subject::MAKE).collect(&:friend_id)
    current_user_id = current_user.id
    statuses = Status.search do
      with(:user_id, (fids << current_user_id))
      with(:subject, Constants::Subject::MAKE)
      paginate(page: params[:page], per_page: 10)
    end
    @statuses = statuses.results
    relations = Relation.search do
      if fids.present?
        with(:friend_id, fids)
        with(:user_id, current_user_id)
        with(:subject, Constants::Subject::MAKE)
        paginate(page: params[:page], per_page: 10)
      end
    end
    @relations = relations.results
    all_activities = (@statuses + @relations).sort_by(&:created_at).reverse
    @activities = Kaminari.paginate_array(all_activities).page(params[:page])
  end
end
