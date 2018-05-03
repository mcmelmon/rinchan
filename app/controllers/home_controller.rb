class HomeController < ApplicationController
  def index
    if params[:sort].present?
      @topics = Topic.by('replies').paginate(page: params[:page])
    else
      @topics = Topic.all.paginate(page: params[:page])
    end
  end
end
