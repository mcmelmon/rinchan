class TopicsController < ApplicationController
  def create
    @topic = current_user.topics.build(topic_params)
    if @topic.save
      flash[:success] = "Topic created!"
      redirect_to user_path(current_user)
    else
      redirect_to root_path
    end
  end

  def destroy
  end

  def edit
  end

  def update
  end

  private

    def topic_params
      params.require(:topic).permit(:subject, :anonymous)
    end
end
