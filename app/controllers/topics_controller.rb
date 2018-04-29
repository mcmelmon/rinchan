class TopicsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user

  def create
    @topic = current_user.topics.build(topic_params)
    if @topic.save
      flash[:notice] = "Discussion created!"
      redirect_to user_path(current_user)
    else
      redirect_to root_path
    end
  end

  def destroy
    # TODO: We may not want to delete all of the replies to a topic.
    @topic.destroy
    flash[:notice] = "Discussion deleted."
    redirect_to request.referrer || root_url
  end

  def edit
  end

  def update
    if @topic.update(topic_params)
      flash[:notice] = "Discussion updated."
      redirect_to user_path(current_user)
    else
      flash[:error] = "There was a problem."
      redirect_to user_path(current_user)
    end
  end

  private

    def topic_params
      params.require(:topic).permit(:subject, :anonymous)
    end

    def correct_user
      @topic = current_user.topics.find_by(id: params[:id])
      redirect_to root_url if @topic.nil?
    end

    def logged_in_user
      #TODO: make into a concern
      unless user_signed_in?
        flash[:danger] = "Please log in."
        redirect_to user_session_path
      end
    end
end
