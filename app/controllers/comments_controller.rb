class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_story, only: [:create]


  def create
    @comment = @story.comments.new(comment_params)
    @comment.user = current_user

    respond_to do |format|
      format.js
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end

  def find_story
    @story = Story.friendly.find(params[:story_id])
  end
end
