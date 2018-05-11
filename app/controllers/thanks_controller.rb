class ThanksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:destroy]
  before_action :set_reply, only: [:create]

  def create
    return if current_user == @reply.user
    @thank = @reply.thanks.build
    @thank.user = current_user
    if @thank.save
      flash[:notice] = 'Reply thanked!'
    end
    redirect_to topic_path(@topic)
  end

  def destroy
    @thank.destroy
    flash[:notice] = 'Reply thank removed.'
    redirect_to request.referrer || root_url
  end

  def index
    @user = current_user # to differentiate between one user's replies and all replies
    @replies = @user.thanks.collect(&:reply).paginate(page: params[:page], per_page: 10)
  end

  private
    def correct_user
      @thank = current_user.thanks.find_by(id: params[:id])
      redirect_to root_url if @thank.nil?
    end

    def set_reply
      @reply = Reply.find_by(id: params[:reply_id])
      @topic = @reply.topic
    end
end

