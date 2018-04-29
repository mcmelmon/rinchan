class HomeController < ApplicationController
  def index
    @topics = Topic.all.limit(9)
  end
end
