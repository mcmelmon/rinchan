class TopicsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:destroy, :edit, :update]
  after_action :tag_topic, only: [:create, :update]

  def create
    @topic = current_user.topics.build(topic_params)
    if @topic.save
      flash[:notice] = 'Discussion created!'
      redirect_to topic_path(@topic)
    else
      redirect_to root_path
    end
  end

  def destroy
    @topic.destroy
    flash[:notice] = 'Discussion deleted.'
    redirect_to request.referrer || root_url
  end

  def show
    @topic = Topic.find_by(id: params[:id])
    if @topic.blank?
      redirect_to root_path
      return
    end
    @replies = @topic.replies.order(updated_at: :desc).paginate(page: params[:page])
  end

  def update
    if @topic.update(topic_params)
      flash[:notice] = 'Discussion updated.'
      redirect_to user_path(current_user)
    else
      flash[:error] = 'There was a problem.'
      redirect_to user_path(current_user)
    end
  end

  private
    def topic_params
      params.require(:topic).permit(:image, :image_cache, :remove_image, :subject).tap do |clean_params|
        clean_params[:subject] = Rails::Html::FullSanitizer.new.sanitize(clean_params[:subject])
      end
    end

    def correct_user
      @topic = current_user.topics.find_by(id: params[:id])
      redirect_to root_url if @topic.nil?
    end

    def tag_topic
      return unless params[:tags].present?
      @topic.clear_tags
      params[:tags].gsub(/\#/, ',').split(',').collect{|tag| tag.strip}.reject(&:blank?).each do |name|
        @topic.tags.create(name: name, user: current_user)
      end
    end
end
