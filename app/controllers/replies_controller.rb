class RepliesController < ApplicationController
  before_action :correct_user, only: [:destroy, :edit, :update]
  before_action :authenticate_user!, only: [:destroy, :edit, :update]
  before_action :set_topic

  def create
    @reply = @topic.replies.build(reply_params)
    @reply.user = current_user || User.guest
    if verify_recaptcha(model: @reply) && @reply.save
      flash[:notice] = t('.reply_created')
    else
      flash[:error] = t('site.flash_problem')
    end
    redirect_to topic_path(@topic)
  end

  def destroy
    @reply.destroy
    flash[:notice] = 'Reply deleted.'
    redirect_to request.referrer || root_url
  end

  def edit
  end

  def new
    @reply = @topic.replies.build
    if @original.present?
      @reply.original_id = @original.id
      @reply.body = "'#{@original.body}'"
    end
  end

  def show
    @reply = Reply.find_by(id: params[:id])
    if @reply.blank?
      redirect_to root_path
      return
    end
    @show_replies = true
  end

  def update
    if @reply.update(reply_params)
      flash[:notice] = 'Reply updated!'
    else
      flash[:error] = t('site.flash_problem')
    end
    redirect_to topic_path(@topic)
  end

  private
    def reply_params
      params.require(:reply).permit(:body, :image, :image_cache, :original_id).tap do |clean_params|
        clean_params[:body] = Rails::Html::FullSanitizer.new.sanitize(clean_params[:body])
      end
    end

    def correct_user
      @reply = current_user.replies.find_by(id: params[:id])
      redirect_to root_url if @reply.nil?
    end

    def set_topic
      @topic = params[:topic_id].present? ? Topic.find_by(id: params[:topic_id]) : Reply.find_by(id: params[:id]).topic
      @original = params[:reply_id].present? ? Reply.find_by(id: params[:reply_id]) : nil
    end
end
