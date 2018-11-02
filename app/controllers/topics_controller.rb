class TopicsController < ApplicationController
  before_action :authenticate_user!, only: [:destroy, :edit, :update]
  before_action :correct_user, only: [:destroy, :edit, :update]
  before_action :find_link, only: [:create, :update]
  after_action :set_link, only: [:create, :update]
  after_action :tag_topic, only: [:create, :update]

  invisible_captcha only: [:create, :update]

  def create
    user = current_user || User.guest
    @topic = user.topics.build(topic_params)
    if @topic.save
      flash[:notice] = t('.discussion_created')
      redirect_to topic_path(@topic)
    else
      flash[:error] = @topic.errors.messages.collect{|m| m[1]}
      redirect_to current_user.present? ? user_path(current_user) : root_path
    end
  end

  def destroy
    @topic.destroy
    flash[:notice] = 'Discussion deleted.'
    redirect_to request.referrer || root_url
  end

  def preview_link
    if params[:link].blank?
      redirect_to root_path
      return
    end
    the_link = params[:link].match(/https?/).blank? ? 'https://' + params[:link] : params[:link]
    object = LinkThumbnailer.generate(the_link)
    render json: object.to_json
  end

  def remove_link
    topic = current_user.topics.find_by(id: params[:id])
    if topic.present?
      topic.topic_link.destroy if topic.topic_link.present?
    end
    render json: nil
  end

  def show
    @topic = Topic.find_by(id: params[:id])
    if @topic.blank? || (@topic.hide && @topic.user != current_user)
      redirect_to root_path
      return
    end
    set_replies
  end

  def update
    if @topic.update(topic_params)
      flash[:notice] = 'Discussion updated.'
      redirect_to user_path(current_user)
    else
      flash[:error] = @topic.errors.messages.collect{|m| m[1]}
      redirect_to user_path(current_user)
    end
  end

  private
    def topic_params
      params.require(:topic).permit(:anonymous, :image, :image_cache, :remove_image, :subject).tap do |clean_params|
        clean_params[:subject] = Rails::Html::FullSanitizer.new.sanitize(clean_params[:subject])
        clean_params[:image] = nil unless current_user.present?
        clean_params[:image_cache] = nil unless current_user.present?
      end
    end

    def correct_user
      @topic = current_user.topics.find_by(id: params[:id])
      redirect_to root_url if @topic.nil?
    end

    def find_link
      return if current_user.blank? || params[:topic][:link_url].present? || @topic&.topic_link.present?
      return unless link_matches = params[:topic][:subject].match(/(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?(?:\ )?/)
      first_link = link_matches[0].strip
      first_link = first_link.match(/https?/).blank? ? 'https://' + first_link : first_link

      object = LinkThumbnailer.generate(first_link) if first_link.present?

      if object.present?
        params[:topic][:link_url] = first_link
        params[:topic][:link_title] = object.title
        params[:topic][:link_description] = object.description
        params[:topic][:link_image_url] = object.images.first.src.to_s
      end
    end

    def set_link
      return unless current_user.present?
      url = params[:topic][:link_url]
      return unless url.present?
      link = TopicLink.new(
        url: url,
        parent_id: @topic.id,
        parent_type: 'Topic',
        title: params[:topic][:link_title],
        description: params[:topic][:link_description],
        image_url: params[:topic][:link_image_url]
        )
      link.save
    end

    def set_replies
      case params[:order]
      when 'up'
        @replies = @topic.replies.sort{|r| r.updated_at}.paginate(page: params[:page])
      when 'down'
        @replies = @topic.replies.sort{|r| r.updated_at}.reverse.paginate(page: params[:page])
      when 'sideways'
        @replies = @topic.replies.select{ |r| r.original.blank? }.paginate(page: params[:page])
        @show_replies = true
      else
        @replies = @topic.replies.sort{|r| r.updated_at}.paginate(page: params[:page])
      end
    end

    def tag_topic
      return unless params[:tags].present?
      @topic.clear_tags
      params[:tags].gsub(/\#/, ',').split(',').collect{|tag| tag.strip}.reject(&:blank?).each do |name|
        @topic.tags.create(name: name, user: current_user || User.guest)
      end
    end
end
