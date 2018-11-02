class RepliesController < ApplicationController
  before_action :correct_user, only: [:destroy, :edit, :update]
  before_action :authenticate_user!, only: [:destroy, :edit, :update]
  before_action :set_topic
  before_action :find_link, only: [:create, :update]
  after_action :set_link, only: [:create, :update]

  invisible_captcha only: [:create, :update]

  def create
    @reply = @topic.replies.build(reply_params)
    @reply.user = current_user || User.guest
    if @reply.save
      flash[:notice] = t('.reply_created')
    else
      flash[:error] = @reply.errors.messages.collect{|m| m[1]}
    end
    redirect_to topic_path(@topic)
  end

  def destroy
    @reply.destroy
    flash[:notice] = 'Reply deleted.'
    redirect_to request.referrer || root_url
  end

  def remove_link
    reply = current_user.replies.find_by(id: params[:id])
    if reply.present?
      reply.topic_link.destroy if reply.topic_link.present?
    end
    render json: nil
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
      flash[:error] = @reply.errors.messages.collect{|m| m[1]}
    end
    redirect_to topic_path(@topic)
  end

  private
    def reply_params
      params.require(:reply).permit(:anonymous, :body, :image, :image_cache, :original_id).tap do |clean_params|
        clean_params[:body] = Rails::Html::FullSanitizer.new.sanitize(clean_params[:body])
      end
    end

    def correct_user
      @reply = current_user.replies.find_by(id: params[:id])
      redirect_to root_url if @reply.nil?
    end

    def find_link
      return if current_user.blank? || params[:reply][:link_url].present? || @reply&.topic_link.present?
      return unless link_matches = params[:reply][:body].match(/(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?(?:\ )?/)
      first_link = link_matches[0].strip
      first_link = first_link.match(/https?/).blank? ? 'https://' + first_link : first_link

      object = LinkThumbnailer.generate(first_link) if first_link.present?

      if object.present?
        params[:reply][:link_url] = first_link
        params[:reply][:link_title] = object.title
        params[:reply][:link_description] = object.description
        params[:reply][:link_image_url] = object.images.first.src.to_s
      end
    end

    def set_link
      return unless current_user.present?
      url = params[:reply][:link_url]
      return unless url.present?
      link = TopicLink.new(
        url: url,
        parent_id: @reply.id,
        parent_type: 'Reply',
        title: params[:reply][:link_title],
        description: params[:reply][:link_description],
        image_url: params[:reply][:link_image_url]
        )
      link.save
    end

    def set_topic
      @topic = params[:topic_id].present? ? Topic.find_by(id: params[:topic_id]) : Reply.find_by(id: params[:id]).topic
      @original = params[:reply_id].present? ? Reply.find_by(id: params[:reply_id]) : nil
    end
end
