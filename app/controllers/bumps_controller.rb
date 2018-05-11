class BumpsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:destroy]
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

  def destroy
    @bump.destroy
    flash[:notice] = 'Topic bump removed.'
    redirect_to request.referrer || root_url
  end

  def index
    @topics = current_user.bumps.collect(&:topic).paginate(page: params[:page], per_page: 10)
  end

  private
    def correct_user
      @bump = current_user.bumps.find_by(id: params[:id])
      redirect_to root_url if @bump.nil?
    end

    def set_topic
      @topic = Topic.find_by(id: params[:topic_id])
    end
end
