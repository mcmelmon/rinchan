class BumpsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_topic

  def create
    return if current_user == @topic.user
    @bump = @topic.bumps.build
    @bump.user = current_user
    if @bump.save
      flash[:notice] = 'Topic bumped!'
    end
    redirect_to topic_path(@topic)
  end

  private
    def set_topic
      @topic = Topic.find_by(id: params[:topic_id])
    end
end
