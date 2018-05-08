class ObjectionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_topic

  def create
    return if current_user == @topic.user
    @objection = @topic.objections.build(objection_params)
    @objection.user = current_user
    if @objection.save
      flash[:notice] = 'Objection filed.'
    end
    redirect_to topic_path(@topic)
  end

  def destroy
    @objection.destroy
    flash[:notice] = 'Objection deleted.'
    redirect_to request.referrer || root_url
  end

  def edit
  end

  def new
    @objection = @topic.objections.build
  end

  def update
  end

  private
    def objection_params
      params.require(:objection).permit(:body)
    end

    def correct_user
      @objection = current_user.objections.find_by(id: params[:id])
      redirect_to root_url if @objection.nil?
    end

    def set_topic
      @topic = Topic.find_by(id: params[:topic_id])
    end
end

