class DemurralsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:destroy]
  before_action :set_reply, only: [:create]

  def create
    return if current_user == @reply.user
    @demurral = @reply.demurrals.build
    @demurral.user = current_user
    if @demurral.save
      flash[:notice] = 'Reply demurred!'
    end
    redirect_to topic_path(@topic)
  end

  def destroy
    @demurral.destroy
    flash[:notice] = 'Reply demurral removed.'
    redirect_to request.referrer || root_url
  end

  def index
    @user = current_user # to differentiate between one user's replies and all replies
    @replies = @user.demurrals.collect(&:reply).paginate(page: params[:page], per_page: 10)
  end

  private
    def correct_user
      @demurral = current_user.demurrals.find_by(id: params[:id])
      redirect_to root_url if @demurral.nil?
    end

    def set_reply
      @reply = Reply.find_by(id: params[:reply_id])
      @topic = @reply.topic
    end
end


