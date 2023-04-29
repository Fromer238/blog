class PagesController < ApplicationController
  before_action :find_story, only: [:show]
  def index
    @story = Story.published_stories
  end

  def show
    @comment = @story.comments.new
    @comments = @story.comments.order(created_at: :desc)
  end

  def user

  end

  private
  def find_story
    @story = Story.friendly.find(params[:story_id])
  end
end
