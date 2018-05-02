class BumpsController < ApplicationController
  before_action :logged_in_user
  before_action :set_topic

  def create
    @bump = @topic.bumps.build
    @bump.user = current_user
    if @bump.save
      flash[:notice] = 'Topic bumped!'
    end
    redirect_to topic_path(@topic)
  end

  private
    def logged_in_user
      #TODO: make into a concern
      unless user_signed_in?
        flash[:danger] = "Please log in."
        redirect_to user_session_path
      end
    end

    def set_topic
      @topic = Topic.find_by(id: params[:topic_id])
    end
end
