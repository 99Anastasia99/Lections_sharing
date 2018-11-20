class CommentsController < ApplicationController
before_action :set_lection, exept: :destroy
before_action :authenticate_user!
  def create
    @comment = @lection.comments.new(comment_params)
    @comment.user = current_user
    @comment.save
  end
  # def destroy
  #   @comment = @lection.comments.find(params[:id])
  #   @comment_id = @comment.id
  #   @comment.destroy
  # end
private
def comment_params
  params.require(:comment).permit (:body)
end
def set_lection
@lection = Lection.find(params[:lection_id])
end
end
