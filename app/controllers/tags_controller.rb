class TagsController < ApplicationController
  def show
    @tag = Tag.find_by(id: params[:id])
    @topics = Topic.with_tag(@tag&.name)
  end
end
