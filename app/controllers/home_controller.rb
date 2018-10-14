class HomeController < ApplicationController
  def index
    if params[:sort].present?
      @topics = Topic.for_homepage(current_user, 'replies').paginate(page: params[:page], per_page: 20)
    else
      @topics = Topic.for_homepage(current_user).paginate(page: params[:page], per_page: 20)
    end
  end
end
