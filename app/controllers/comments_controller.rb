class CommentsController < ApplicationController
  before_filter :load_commentable

  def new
    @commentable = load_commentable  
  end

  def index
    @comments = @commentable.comments
  end

  def create
    @comment = @commentable.comments.build(comment_params)
    if @comment.save
      respond_to do |format|
        format.js
      end
    else
      redirect_to root_path
    end
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
