class HomeController < ApplicationController
  def index
    @tags = Tag.unique_names
  end
end
