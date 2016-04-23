class CommentsController < ApplicationController
  before_filter :load_commentable

  def index
    @comments = @commentable.comments
  end

  private
    def load_commentable
      klass = [Status, Relation, Comment].detect {|c| params["#{c.name.underscore}_id"]}
      @commentable = klass.where(id: params["#{klass.name.underscore}_id"]).first
    end

    def comment_params
      params.require(:comment).permit(:content, :commentable_id, :commentable_type)
    end
end
